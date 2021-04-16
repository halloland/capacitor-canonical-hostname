import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CanonicalHostname)
public class CanonicalHostname: CAPPlugin {

    @objc func getCanonicalHostname(_ call: CAPPluginCall) {
        let addressStr = call.getString("ip") ?? ""

        let res = reverseDNS(ip: addressStr)
        call.success([
            "hostname": res
        ])
    }
    
    func reverseDNS(ip: String) -> String {
        var results: UnsafeMutablePointer<addrinfo>? = nil
        defer {
            if let results = results {
                freeaddrinfo(results)
            }
        }
        let error = getaddrinfo(ip, nil, nil, &results)
        if (error != 0) {
            print("Unable to reverse ip: \(ip)")
            return ip
        }

        for addrinfo in sequence(first: results, next: { $0?.pointee.ai_next }) {
            guard let pointee = addrinfo?.pointee else {
                print("Unable to reverse ip: \(ip)")
                return ip
            }

            let hname = UnsafeMutablePointer<Int8>.allocate(capacity: Int(NI_MAXHOST))
            defer {
                hname.deallocate()
            }
            let error = getnameinfo(pointee.ai_addr, pointee.ai_addrlen, hname, socklen_t(NI_MAXHOST), nil, 0, 0)
            if (error != 0) {
                continue
            }
            return String(cString: hname)
        }

        return ip
    }
}
