package Responders;

import junit.framework.Assert;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class PlayGameTest {
    PlayGame playGame = new PlayGame();
    Hashtable req, resp;

    @Before public void init() {
        req = new Hashtable();
    }

    @Test public void retrievesCookies() throws IOException {
        Hashtable body = new Hashtable();
        body.put("playerMove", "5");
        req.put("Cookie", "board=_________; playerOne=h; playerTwo=c; boardSize=3");
        req.put("Method", "POST");
        req.put("Body", body);
        resp = playGame.respond(req);
        List<String> cookies = playGame.cookies;
        assertEquals(true, !cookies.isEmpty());
    }

    @Test public void parseCookies() {
        req.put("Cookie", "board=_________; playerOne=h; playerTwo=c; boardSize=3");
        Hashtable cookies = playGame.parseCookie(req);
        assertEquals("_________", cookies.get("board"));
        assertEquals("h", cookies.get("playerOne"));
        assertEquals("c", cookies.get("playerTwo"));
        assertEquals("3", cookies.get("boardSize"));
    }

    @Test public void storeCookies() {
        Hashtable body = new Hashtable();
        body.put("playerMove", "5");
        req.put("Cookie", "board=_________; playerOne=h; playerTwo=c; boardSize=3");
        req.put("Method", "POST");
        req.put("Body", body);
        resp = playGame.respond(req);
        List<String> cookies = playGame.cookies;
        assertEquals(cookies.get(1), "playerOne=h; path=/player_move");
        assertEquals(cookies.get(2), "playerTwo=c; path=/player_move");
        assertEquals(cookies.get(3), "boardSize=3; path=/player_move");
    }

    @Test public void getMethodForPlayGame() {
        req.put("Method", "GET");
        req.put("Cookie", "board=XO_______; playerOne=c; playerTwo=c; boardSize=3");
        resp = playGame.respond(req);
        String body = new String((byte[]) resp.get("message-body"));
        Assert.assertTrue(body.contains("X"));
    }
}
