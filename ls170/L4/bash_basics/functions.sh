greeting () {
  echo Hello $1
}

greeting 'Peter' # outputs 'Hello Peter'


greeting2 () {
  echo "Hello $1"
  echo "Hello $2"
}

greeting2 'Peter' 'Paul' # outputs 'Hello Peter' 'Hello Paul' on separate lines
