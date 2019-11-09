# The Internet
## Internet and how it works

At a very basic scale, two devices communicating through a LAN cable forms a network, and the **Internet** is an enourmous network of  such networks formed in different scales. The Internet is a combination of:

* **Physical network infrastructure** such as routers, switches, cables and modems.
* **Protocols** enables a functioning infrastructure. Protocols or initially *set of rules and standards* control the data transmission and communication through internet. Certain protocols are in use to address different aspects of network communication where as other protocols are used to address the same aspect of network communication but they achieve this in a different way.

Types of devices communicating over Internet and the software these devices use vary. There are other devices that are responsible for communication which are also connected to Internet. We use protocols within a layered system of communication to ensure:

* Data is transferred from one device to another
* Devices can access World Wide Web.

## Latency, Bandwidth and other characteristics of physical network

* **Latency** is **the amount of time** that it takes for data to travel from one point to another.
To determine the overall latency of a network connection we measure delay. There are different types of delay sum of which defines the 
total latency. (*Propagation delay, Transmission delay, Processing delay, Queuing delay*).
Latency is something that every software engineer need to take into account(and optimise) since it has a significant impact on performance of networked applications.
* **Bandwidth** is **the amount of data** that can be transferred from a device at once.
* **Bit rate** is **the amount of bits** that can be transferred by a device over a given period of time.
* A **Network hop** is the transfer of data from one node to another. Data does not neccesarily follow a direct path on the network. It moves from one node to another (one network hop at a time) depending on network availability.
* **Nodes** are network devices that process the data and pass it forward to the next node on the path.
* **Data encapsulation** works in a similar way to encapsulation in programming. By encapsulating data in data unit of the layer below we can hide the internal information of a certain layer. This implementation stacked across protocols at different layers and forms a 
system where a protocol at one layer serves to the next layer.
* **Protocol Data Unit(PDU)** is used for the implementation of encapsulation. It represents the data that is transferred over the
network. It consists of a **Header**, a **Data Payload** and an sometimes **Trailer/Footer**.
* **Miltiplexing** is the idea of multiple signals(essentially data) can be carried over a single channel. Light-waves in different wave lengths carried on the same fiber-optic cable is an example of **multiplexing in physical layer**. In transport layer this happens through **network ports**.
* **MAC Address** Media Access Control Address is often called "physical address" or "burned-in address". It is a sequence of two digit six numbers such as `9C-B6-D0-B6-DE-B3`. It is assigned to a network enabled device during manufacturing and usually does not change. In a LAN communication scenario we can use MAC address to identify the sender and the receiver of a particular message. However, they are not ideal for inter-network communication because MAC addresses are **flat** and unique to each device. For this reason we use more **hierarchical** systems for Internet communication.

## How lower protocols operate

* **Physical Network** is the bottommost layer responsible for the transfer of binary data. **Link layer at TCP** includes some of this
physical functionality where as **Physical layer at OSI** is the bottommost layer. Binary data is transformed into physical entities so it can be to transferred over the physical infrastructure (electrical signals, light or radio waves,etc.)
* **The Link/Data Link Layer** serves as an interface layer between the physical network and the logical layers.
The Ethernet Protocol is the most commonly used protocol at this layer.
PDU of this layer is called **Ethernet Frame**.
Header of the PDU includes source and destination **MAC Addresses** which are the most important aspects of the data transfer with **Data  Payload**.
* **The Transport Layer** is concerned of end-to-end communication between different processes and applications is achieved with reliability.
* **The Internet/Network Layer** is the layer of protocols that are responsible for inter-network communication.
  *  **OSI's Network layer(3)** and **TCP/IP's Internet Layer(2)** serves this function.
  * The most commonly used protocol is **IP (The Internet Protocol)**. PDU of this layer is called **Data Packets**.
  * Primary functions of this layer are; Encapsulating data into **Packets**, and routing through **IP Addressing**

## IP address and a port number

* **IP address** are hierarchical compared to MAC addresses, and can be can be dynamically assigned to a device as it joins the network.
  * The hierarchical logic of IP address works similar to post codes. This layered structure makes routing easier through finding the network first by searching if the IP address belongs to this network(network address). Machines on the same network share this address as part of their IP address. This is followed by an IP look-up to identify the device that message to be delivered to.
  * There are two versions of IP addressing currently in use. **IPv4** and **IPv6**. The former is an earlier version put in use around 80s where as the latter one is developed mid 2000s to overcome the limititation in total number of devices that IPv4 support.
* **Network port** is an identifier for an application or a process to run on a host. They add further detail to inter-network communication based on IP addressing.

## DNS and how it works

**DNS(Domain Naming System)** is a distributed database responsible for translation of URLs such as `https://twitter.com` to an IP address and mapping the request to a remote server.This database of URLs and their corresponding IP Addressess are stored on DNS servers. The idea behind DNS is distributing this database between hierarchically organised DNS servers worldwide, because practically no single server can maintain the whole database.

## Client-server model of web interactions and the role of HTTP protocol within the model

* A simple web interaction occurs between the client(web browser) and the server(receiver of the request) in form of request/response cycle.
* The client and the server follows HTTP protocol so that server can understand the components of client's request, and respond back in a form that also follows HTTP protocol.
* This cycle forms the basis of modern web interaction where HTTP is at the core, ensuring uniformity to resource transfer between applications.
* **Resource** is a broad term meaning the data that we interact with on Internet. It can be in the form of files, web pages, software, etc.

# TCP & UDP
## TCP and UDP protocols, and their comparison
* Transport layer forms a reliable network communication on top of an unreliable channel(of Physical layer and Link/Data Link layers)
* This helps us hide the complexity of forming a reliable network communication from the application layer.
* **TCP(Transmission Control Protocol)** and **UDP(User Datagram Protocol)** are two common protocols we use at this layer.
* **TCP** is a connection-oriented protocol, provides:
  * Multiplexing and demultiplexing
  * In order delivery
  * De-duplication
  * Message acknowledgement and retransmission
  * Error detection
* **UDP** is a connectionless protocol, provides:
  * Multiplexing and demultiplexing
  * Error detection
* **TCP** is more reliable compared to UDP. However, this brings the cost of latency overhead of establishing a connection and the the risk of Head-of-line blocking due to in-order delivery.
* **UDP** is faster and simpler compared to TCP. Main downside is that it lacks the functionality of TCP. In use of UDP, it is software engineers decision/responsibility to build-up these functionality at the top of UDP when/if they needed.
* The main(and important) similarity of TCP/UDP is multiplexing/demultiplexing which forms the core of reliability on an unreliable communication channel. 
* **Miltiplexing** is the idea of multiple signals(essentially data) can be carried over a single channel. Light-waves in different wave lengths carried on the same fiber-optic cable is an example of **multiplexing in physical layer**. In transport layer this happens through **network ports**.
* A **network socket** is communication end point formed by combining an IP address and a port number

## Three-way handshake and its use

* TCP uses Three-way handshake to establish a reliable connection between the client and the host.
* PDUs that TCP use are called **Segments**
* Segment header contains various information such as Source and Destination port as well as **SYN** and **ACK** flags that are used during Three-way handshake.
* **SYN** stands for Synchronise
* **ACK** stands for Acknowledgement

1. Sender(the client, wants to form the connection) sends a SYN message(sets SYN flag to 1).
2. Receiver(the server, confirms that message is received) answers back a SYN ACK message(both SYN and ACK flags are set to 1).
3. Sender(acknowledging the response) sends back an ACK message(ACK flag is set to 1).

After Three-way handshake sender starts sending the application data.

## Flow control and congestion avoidance

* **Flow control** is an important mechanism of TCP protocol, protecting receiver from being overwhelmed by the receiver sending too much data in one go.
* By setting the **Window** field of a TCP segment, receiver can inform the user about the amount of data it wants to accept.
* This mechanism focuses on capabilities of the sender and the receiver, does not concern overwhelming the underlying network
* Packages hop between network nodes where they get processed.
* A router runs a checksum at each hop and trasfer data to next node. Due to routers processing capability, packages queue to be processed and if the queue is full they get dropped.
* In case data getting lost, sender sends same packages in a certain frequency until it receives an acknowledgement message for the initial package it sent.
* TCP control this process by congestion window and when data flow is overloaded, windows size decreases to reduce the amount of data being sent in one go.
* This is how TCP deals with network overloading.

# URLs
## Components of URL, query strings

* **URL(Uniform Resource Locator)** is the most widely used part of **URI(Uniform Resource Identifier)**
* URL sets how resources located.
* For URL: `http://www.example.com:88/home?item=book`
* `http`: The **scheme** specifies how to access the resource by the web client. Although used interchangibly with the protocol, scheme sets which protocol to be used to access the resource.
* `example.com`: The **host** or domain name used by the DNS, and mapped into an IP address. Informs client where to look at for the resource.
* `:88` The **port** or the port number specifies which port to be used. It is an optional part of the URL, if not entered the default port number will be used by the request.
* `/home/`: The **path** is used to tell the server that where the requested resource is located in the server.
* `?item=book`: The **query string** is made out of **query parameters**. This optional part of the URL is used to transfer data through the URL.

* We use `?` character to mark the beginning of the **query string**.
* `item=book` is a parameter name/value pair.
* we can chain query paramters with `&` reserved character.

## Constructing a valid URL
## URL encoding and its use

# HTTP and the Request/Response Cycle
## HTTP requests and responses, and their components
## Description of HTTP request/response cycle
## Status codes and their use(samples)
## 'State' in the context of web and techniques to simulate state
## Difference between `GET` and `POST` and their use cases

# Security
## Various security risks that can affect HTTP, and strategies been developed against these risks
## Different services TLS can provide
