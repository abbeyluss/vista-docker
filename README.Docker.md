### Building and running your application
Put the Dockerfile in the same folder as the ViSTA code and then do the following

To build it:
docker build -t vistadocker .

To run it: 
docker run -t -i --name [ADD DESIRED NAME HERE] -p 80:80 vistadocker