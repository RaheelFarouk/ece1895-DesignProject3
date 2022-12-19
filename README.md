# **Design Project 3 – Designing a Live Telemetry System**

# Design Overview

This project was developed for ECE 1895 – Junior Design at the University of Pittsburgh.
 The purpose of this project was to develop a Live Telemetry system for use in Automotive and Motorsport applications. The live telemetry system is used to be able to analyse data from sensors and actuators on the vehicle remotely and in real time. It consists of a device called the Vehicle Telemetry Module (VTM) that goes inside a vehicle and connects to the CAN bus on the vehicle. The CAN bus is a network protocol used in automotive applications to send data and allow multiple devices to communicate with each other two wires. This Vehicle Telemetry Module then uses ethernet to connect to a 4G Router to send this data over the internet to a server that receives that data, and forwards it to the client (the data analysis workstation).

### Timeline

This was a six week project and this was the timeline I followed for the project:

- 1st week: Prototype and make CAN Bus code
- 2nd week: Start working on Ethernet Code
- 3rd week: Combine both CAN and Ethernet Code
- 4th week: Start working on server-side code to retrieve data
- 5th week: Test the system
- 6th week: Continue testing and debugging and 3D print enclosure

In the six weeks I was also able to work on a custom PCB for the vehicle telemetry module and also write a basic MATLAB script for the client side to receive data from the server.

### Vehicle Telemetry Module Considerations

The initial considerations for the vehicle telemetry module were as follows:

For the microprocessor I chose an ATMEGA328P, as it was the chip used in an Arduino and had both enough memory and processing power for the initial application. In addition, I also had an Arduino UNO available and thought it would be a good prototyping platform to get started on.

For the CAN bus communication, I chose an MCP2515 as the CAN controller and a MCP2551 for the CAN transceiver. Again, this decision was influenced by the fact that there was already a CAN shield developed for the Arduino and I had prior experience with using the SPI bus which is what this shield used to communicate with the Arduino. For this I used the autowp-mcp2515 library found here: [https://www.arduino.cc/reference/en/libraries/autowp-mcp2515/](https://www.arduino.cc/reference/en/libraries/autowp-mcp2515/)

For the Ethernet module I chose to use the Arduino Ethernet shield V2. This shield also used SPI to communicate with the ATMEGA328 Chip. Therefore, I decided to use it. I used the getting started guide on the Arduino website to get this ethernet shield to work with the Arduino. [https://docs.arduino.cc/tutorials/ethernet-shield-rev2/udp-send-receive-string](https://docs.arduino.cc/tutorials/ethernet-shield-rev2/udp-send-receive-string)

### Server Code Considerations

For the server code I decided to use python. This was because I had used python in the past and I found out that python already and an in-built library for UDP communication. Since it was in-built it also had great documentation that I was able to make use of. This was a fairly straight forward decision as I had never done anything like this in the past and didn't really know what other options there was, in the future I will look into this and see if there are any better options for the server-side code. [https://wiki.python.org/moin/UdpCommunication](https://wiki.python.org/moin/UdpCommunication)
[https://pythontic.com/modules/socket/udp-client-server-example](https://pythontic.com/modules/socket/udp-client-server-example)

### Client Code Considerations

At this time, I haven't decided what to do with the client-side interface; however, I had time at the end to do some basic coding in MATLAB to make a script that is able to connect to the server and get some data from the server.

# Preliminary Design Verification

## Hardware

For the initial prototype stage, I used an Arduino UNO with the Ethernet shield and the CAN shield.

![](/Media/ReadmeImages/image002.png)


![](/Media/ReadmeImages/image004.jpg)


## Software

I split this prototyping stage up into three parts. Firstly, I got the Arduino to read data from the CAN bus. Secondly, I got the Arduino to be able to send messages using UDP to a simple receive script that I made on the server. Thirdly, I combined the code to receive data from the CAN bus and then send it using the UDP protocol to the simple server script.

#### Reading CAN data using the Arduino

![](/Media/ReadmeImages/image006.png)

_Receive Code Snippet_


![](/Media/ReadmeImages/image008.png)

_Serial Output_


As you can see in the above two images, I was able to read data from the CAN bus. The data being transferred on the CAN bus is just a basic counter in the last byte.

#### Sending Data using the UDP Protocol

![](/Media/ReadmeImages/image010.png)

_UDP Send Test code snippet_


![](/Media/ReadmeImages/image012.png)

_Console output on the server_


#### Receiving CAN Data and Sending it Using the UDP Protocol

![](/Media/ReadmeImages/image014.png)

_CAN data receive and send code snippet._


![](/Media/ReadmeImages/image016.png)

 _Console output on the server._


# Design Implementation

![](/Media/ReadmeImages/image018.png)

_Schematic for the Microprocessor and CAN Chips_


![](/Media/ReadmeImages/image020.png)

_PCB Layout for the Microprocessor and CAN Chips_


![](/Media/ReadmeImages/image022.png)

_Schematic for the ethernet module_


![](/Media/ReadmeImages/image024.jpg)

_Schematic for the ethernet module_


# Design Testing

### Assembled Boards

![](/Media/ReadmeImages/image026.jpg)

_Main board with ATMEGA328 and CAN Chips_


![](/Media/ReadmeImages/image028.jpg)

_Ethernet Board_


![](/Media/ReadmeImages/image030.jpg)

_Underside of Ethernet board_


![](/Media/ReadmeImages/image032.jpg)

_Plugging in the ethernet boards to the main board_


![](/Media/ReadmeImages/image034.jpg)

_The complete stack_


### Testing

To test out the system I carried out the same tests that I did when initially prototyping the system. I used another development board to simulate the CAN bus on a vehicle and send CAN messages to my Vehicle Telemetry Module. I sent a basic message with a counter that sends an integer from 0 to 15 in the last byte of the CAN message. The development board that is set to simulate the car is set to send a CAN message every 50 milliseconds.

![](/Media/ReadmeImages/image036.png)


![](/Media/ReadmeImages/image038.png)

_The test setup_


![](/Media/ReadmeImages/image040.png)

 _Code for the CAN dev-board that is simulating the car_


![](/Media/ReadmeImages/image042.png)

 _Console output of the running code_


![](/Media/ReadmeImages/image044.png)

 _Basic MATLAB Script reading broadcasted data from the server_


![](/Media/ReadmeImages/image046.jpg)


![](/Media/ReadmeImages/image048.jpg)

 _3D printed enclosure for the Vehicle Telemetry Module_
 

# Summary, Conclusions and Future Work

In summary, the system works as it is intended. A few things that I would like to accomplish in the future is to make both my PCBs smaller and also possibly integrate it into one PCB. I had not taken into account the height and positions of certain components and had to therefore bend some components out of the way; this is something that I intent to fix in future versions. Another thing I would like to do is test out the data transfer rate at which messages are starting to be missed or lost. A future addition to the server-side code is to add a GUI and to make a client software to analyse the data.