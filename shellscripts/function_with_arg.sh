#!/bin/bash
exec > >(tee /tmp/tmp.log) 2>&1
my_details(){
  echo ""
  echo "Script runs at: $(date '+ %Y-%m-%d %H:%M:%S')"
  echo "Hello, My name is $1."
  echo "I'm based out $2, India."
  echo "Working as a Senior $3 Engineer at Try-devOps.xyz"
}
profile_summary(){
  echo ""
  echo "I carrying around a decade of experience in IT as Senior Engineer, DevOps."
}
my_details "Steve" "Bangalore" "Software"
profile_summary
