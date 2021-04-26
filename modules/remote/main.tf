
resource "null_resource" "compute-script1" {
  provisioner "file" {
    connection {
      type        = "ssh"
      host        = var.public-ip1
      user        = var.instance_user
      private_key = var.private_key
    }
    source      = "scripts/"
    destination = "/home/opc/"
  }

  provisioner "remote-exec" {
    connection {
      host        = var.public-ip1
      user        = var.instance_user
      private_key = var.private_key
    }

    inline = [
      "touch /home/opc/temp.txt",
      "chmod +x /home/opc/test.sh",
      "sudo yes | /home/opc/test.sh > /home/opc/c1output1.txt"
    ]
  }
}
