# METADATA
# title: Custom disallow ingress to RDP port from any IP address.
# description: |
#   RDP access can be configured on either the network security group or in the network security group rule.
#   RDP access should not be permitted from the internet (*, 0.0.0.0, /0, internet, any)
# scope: package
# schemas:
#   - input: schema["cloud"]
# custom:
#   id: AVD-CUSTOM-0001
#   avd_id: AVD-CUSTOM-0001
#   provider: azure
#   service: network
#   severity: CRITICAL
#   short_code: RDP-blocked-from-internet
#   recommended_action: Block port 3389 access from the internet
#   input:
#     selector:
#       - type: cloud
#         subtypes:
#           - service: network
#             provider: azure

package user.azure.nsg

import rego.v1

import data.lib.net

deny contains res if {
	some group in input.azure.network.securitygroups
	some rule in group.rules
	rule.allow.value
	not rule.outbound.value
	lower(rule.protocol.value) != "icmp"
	some ports in rule.destinationports
	port_range_includes(ports.start, ports.end, 3389)
	some ip in rule.sourceaddresses
	net.cidr_allows_all_ips(ip.value)
	res := result.new(
		"Security group rule allows unrestricted ingress to SSH port from any IP address.",
		ip,
	)
}

port_range_includes(from, to, port) if {
	from.value <= port
	port <= to.value
}