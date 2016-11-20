package socket;

import java.io.IOException;
import java.net.InetAddress;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.UnknownHostException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/Control")
public class Control {
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	WebsocketClientEndpoint clientEndPoint = null;
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		synchronized (clients) {
			for (Session client : clients) {
				if (!client.equals(session)) {
				}
			}
	        //System.out.println(InetAddress.getLocalHost().getHostAddress());
			clientEndPoint.addMessageHandler(new WebsocketClientEndpoint.MessageHandler() {
			    public void handleMessage(String message) {
			    }
			});
			clientEndPoint.sendMessage(message);
		}
	}

	@OnOpen
	public void onOpen(Session session) {
        try {
			clientEndPoint = new WebsocketClientEndpoint(new URI("ws://" + InetAddress.getLocalHost().getHostName() + ":8080"  + "/Timer/Timer"));
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(session);
		clients.add(session);
	}

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("control client is now disconnected");
	}
}