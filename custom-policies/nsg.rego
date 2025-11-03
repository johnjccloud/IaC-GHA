
 METADATA
 title: Disallow 'Any', 'VirtualNetwork', or 'Internet' as source address in inbound NSG rules
 description: Azure NSG rules should not allow traffic from Internet, VirtualNetwork, or any (*) as source address
 scope: package
 related_resources:
 - description: documentation
   ref: https://learn.microsoft.com/en-us/azure/security/fundamentals/network-best-practices
 schemas:
  - input: schema.input
 custom:
   avd_id: AVD-AZU-CUSTOM01
   category: NETWORK SECURITY
   severity: HIGH
   provider: azure
   input:
     combine: false
     selector:
     - type: json
package user.azure.nsg

import rego.v1

deny contains msg if {
	some resource in input.planned_values.root_module.resources
	resource.type == "azurerm_network_security_rule"
	src := resource.values.source_address_prefix
	disallowed_source[src]
	msg := sprintf("NSG rule with name %s is disallowed to have source address prefix: %s", [resource.values.name, src])
}

deny contains msg if {
	some resource in input.planned_values.root_module.resources
	resource.type == "azurerm_network_security_rule"
	some src in resource.values.source_address_prefixes
	disallowed_source[src]
	msg := sprintf("NSG rule with name %s is disallowed to have source address prefixes: %s", [resource.values.name, src])
}

disallowed_source := {
	"VirtualNetwork",
	"0.0.0.0/0",
	"*",
	"Internet",
}
