job "discordbots" {
	name = "discordbots"
	datacenters = ["oci-primary"]

	vault {
		policies = ["read-kv"]
	}

	group "soupbot" {
		task "soupbot" {
			driver = "docker"
			config {
				image = "ghcr.io/u1f408/soupbot:version"
			}

			resources {
				cpu = 50
				memory = 150
			}

			template {
				env = true
				destination = "local/secret.env"

				data = <<EOD
					{{ with secret "kv/soupbot" }}
					DISCORD_TOKEN={{ .Data.data.discordToken }}
					{{ end }}
				EOD
			}
		}
	}
}
