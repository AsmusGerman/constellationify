MATLAB Production Server

Before you can use the functions packaged by the compiler, you need to do the following:
. Deploy Constellationify.ctf to a server instance
. Develop a client application to access the functions.

1. Deploy Constellationify.ctf

1.1 Prerequisites to Deployment
Before you can deploy Constellationify.ctf you need a server instance to host it. The 
server instance must be configured to have access to MATLAB runtime 8.5.
* If you do not have a server instance created see [Server 
  Creation](http://mathworks.com/help/mps/creating_a_server.html).
* If you do not have version 8.5 of the MATLAB runtime installed download the installer 
  from the MATLAB runtime 
  page(http://www.mathworks.com/products/compiler/mcr/index.html). For more information 
  see [Working with the MATLAB 
  runtime](http://www.mathworks.com/help/compiler/working_with_the_mcr.html).
* If you need to configure the server instance to use the version 8.5 of the MATLAB 
  runtime see [Configuration File 
  Customization](http://www.mathworks.com/help/mps/customize-the-configuration-file.html).

1.2 Constellationify.ctf Deployment
To deploy Constellationify.ctf copy it into the server instance's `auto_deploy` folder. 
The server instance will automatically deploy it and make it available to interested 
clients.

2. Develop Client Applications
MATLAB Production Server officially supports the following clients:
* C/C++(http://www.mathworks.com/help/mps/cxx-client-programming.html)
* .NET(http://www.mathworks.com/help/mps/dotnet-client-programming.html)
* Java(http://www.mathworks.com/help/mps/java-client-programming.html)
* Python(http://www.mathworks.com/help/mps/python-client-programming.html)

2.1 C/C++ 
The C/C++ client libraries are located in a platform specific folder at `MPS_INSTALL/client/c`.
The header files are locatated in `MPS_INSTALL/client/c/include 
For information about developing C/C++ clients see: 
* [C/C++ Client Programming](http://www.mathworks.com/help/mps/cxx-client-programming.html)
* example code at `MPS_INSTALL/client/c/examples' 
* included C/C++ client documentation at `MPS_INSTALL/client/c/doc/index.html'

2.2 .NET
The .NET client libraries are located at 
`MPS_INSTALL/client/dotnet/MathWorks.MATLAB.ProductionServer.Client.dll`.
For information about developing .NET clients see:
* [.NET Client Programming](http://www.mathworks.com/help/mps/dotnet-client-programming.html)
* example code at `MPS_INSTALL/client/dotnet/examples'
* included .NET client documentation at 
`MPS_INSTALL/client/dotnet/doc/MathWorks.MATLAB.ProductionServer.Client.chm`)

2.3 Java
The Java client libraries are located at `MPS_INSTALL/client/java/mps_client.jar`.
For information about developing Java clients see:
* [Java Client Programming](http://www.mathworks.com/help/mps/java-client-programming.html)
* example code at `MPS_INSTALL/client/java/examples'
* included Javadoc at `MPS_INSTALL/client/java/doc/index.html`

2.4 Python 
The Python client package includes the following: 
* mlarray - a set of classes for creating multi-dimensional MATLAB arrays 
* production_server - API for evaluating functions on a remote MATLAB Production Server 
  instance

The Python client installer is located at `MPS_INSTALL/client/python/setup.py`. To 
install the client go to the python folder and execute:
 
python setup.py install 

For information about developing Python clients see: 
* [Python Client Programming](http://www.mathworks.com/help/mps/python-client-programming.html)
* example code at `MPS_INSTALL/client/python/examples'
