alias tfplan="terraform plan -out ~/ops/tfplans/\$(basename \$(pwd))_\$(date +%F_%H_%M_%S).tfplan"
alias tfapply="terraform apply ~/ops/tfplans/\$(ls -w1 -t ~/ops/tfplans | head -1)"
