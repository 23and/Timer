package socket;

import java.io.IOException;
import java.net.InetAddress;
import java.net.URI;
import java.net.URISyntaxException;
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
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println(message);
		synchronized (clients) {
			for (Session client : clients) {
				if (!client.equals(session)) {
					//client.getBasicRemote().sendText(message);
				}
			}
	        try {
	            // open websocket
	        	System.out.println(InetAddress.getLocalHost().getHostAddress());
	            final WebsocketClientEndpoint clientEndPoint = new WebsocketClientEndpoint(new URI("ws://" + InetAddress.getLocalHost().getHostName() + ":8080"  + "/Timer/Timer"));
	            // add listener
	            clientEndPoint.addMessageHandler(new WebsocketClientEndpoint.MessageHandler() {
	                public void handleMessage(String message) {
	                    System.out.println(message);
	                }
	            });
	            clientEndPoint.sendMessage(message);
	            //Thread.sleep(5000);
	        } catch (URISyntaxException ex) {
	            System.err.println("URISyntaxException exception: " + ex.getMessage());
	        }
		}
	}

	@OnOpen
	public void onOpen(Session session) {
		System.out.println(session);
		clients.add(session);
	}

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("client is now disconnected");
	}
}