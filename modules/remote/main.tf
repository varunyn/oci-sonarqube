
resource "null_resource" "compute-script1" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = var.public-ip1
      agent       = false
      user        = "opc"
      private_key = var.private_key
      timeout     = "5m"
    }

    inline = [
      "while [ ! -f /tmp/cloud-init-complete ]; do sleep 1; done",
      "docker run --detach -p 9000:9000 sonarqube"
    ]
  }
}
