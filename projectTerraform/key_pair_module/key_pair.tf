variable "key_name" {}
resource "aws_key_pair" "ec2-testing-terraform" {
  key_name   = "${var.key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAudaHbo71fMcr+QdJxj9ymmnfmAlbXC4ZnbOrrRHaAEAznIEDuxvdqxqsgrQEHRN2T2wZIHgXHjyEL65ebrGHxAJuavxaYPBLOnckVxA/6LEkkcY51+a7KX+9dL/Vb3TMdylSahGAbtyTxnZIbkp1TC5QsBvQsyHevxE3grrw5cBimgPWiGachYFdt0L5rFWUFqxIHtEgy0hSKUYE1sFYdHHfbv+zitgNn+F0q7f9CtX11eO7zVSvZluTyoMzT41erQVUZ4VpoWcD90WfVdKAnCDx0zM3No3SIYzBj2sR3Z+ELKGuYOn/hqrY6ugmlwAo1yAeADD5s/k9WaAiJHl1kS51ecU5VUX7rl5Vyro0j1b6lDntOJ/Bv1/EFxsThmnbHtt/c7Co3hacLPUWlQG3SOTbwiNWgFhfLATYinImlL8qSdwPEwsvaExqtgLpTwST/XH7iqqNe/e3VbJplRQb7sLn/yW/j8IoHyZpxs/Yvl3pxXaGHDXoBaOb9+zOe08= sagar@sagar-pc"
}

output "key_pair_name" {
    value = "${var.key_name}"
}