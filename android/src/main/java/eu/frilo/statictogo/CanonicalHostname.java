package eu.frilo.statictogo;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

import java.net.InetAddress;

@NativePlugin
public class CanonicalHostname extends Plugin {

    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", value);
        call.success(ret);
    }

    @PluginMethod
    public void getCanonicalHostname(PluginCall call) {
        try {
            InetAddress ia = InetAddress.getByName(call.getString("ip"));
            JSObject res = new JSObject();
            res.put("hostname", ia.getCanonicalHostName());
            call.success(res);
        } catch (Exception ignored) {
            call.reject("Not found");
        }
    }

}
