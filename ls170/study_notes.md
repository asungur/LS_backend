# The Internet
## Internet and how it works

At a very basic scale, two devices communication through a LAN cable forms a network, and the **Internet** is an enourmous network of  such networks in different scales. The Internet is a combination of:

* **Physical network infrastructure** such as routers, switches, cables, modems.
* **Protocols** enables a functioning infrastructure. Protocols or initially *set of rules and standards* control the data transmission and communication through the internet. Certain protocols are in use to address different aspects of network communication where as other protocols are used to address the same aspect of network communication but they achieve this in a different way.

Types of devices communicating over Internet and the software these devices use vary a lot. There are other physical devices that are part of the physical infrastructure which are also connected to Internet. We use protocols within a layered system of communication to ensure:

* Data is transferred from one device to another
* Devices can access World Wide Web.

## Latency, Bandwidth and other characteristics of physical network

* **Latency** is **the amount of time** that it takes for data to travel from one point to another.
To determine the overall latency of a network connection we measure delay. There are different types of delay, sum of which defines the 
total latency. (Propagation delay, Transmission delay, Processing delay, Queuing delay)
* **Bandwidth** is **the amount of data** that can be transferred from a device at once.
* **Bit rate** is **the amount of bits** that can be transferred by a device over a given period of time.
* A **Network hop** is the transfer of data from one node to another.
* **Nodes** are network devices that process the data and pass it forward to the next node on the path.
* **Data encapsulation** works in a similar way to encapsulation in programming. By encapsulating data in data unit of the layer below we can hide the internal information of a certain layer. This implementation stacked across protocols at different layers and forms a 
system where protocol of one layer serves to the next one.
* **Protocol Data Units(PDU)** is used for the implementation of encapsulation. It represents the data that is transferred over the
network. It consists of a **Header**, a **Data Payload** and an occasional **Trailer/Footer**.
* **Miltiplexing** is the idea of multiple signals(essentially data) can be carried over a single channel. Light-waves in different wave lengths carried on the same fiber-optic cable is an example of **multiplexing in physical layer**. In transport layer this happens through **network ports**.
* **Network port** is an identifier for an application or a process to run on a host.

## How lower protocols operate

* **Physical Network** is the bottommost layer responsible for the transfer of binary data. **Link layer at TCP** includes some of this
physical functionality where as **Physical layer at OSI** is the bottommost layer. Binary data is transformed into physical entities to 
be able to transfermed.(electrical signals, light or radio waves,etc.)
* **The Link/Data Link Layer** serves as an interface layer between the physical network and the logical layers.
The Ethernet Protocol is the most commonly used protocol at this layer.
PDU of this layer is called **Ethernet Frame**.
Header of the PDU includes source and destination **MAC Addresses** which are the most important aspects of the data transfer with Data   Payload.
* **The Transport Layer** is concerned of end-to-end communication between different processes and applications is achieved with reliability.


**MAC Address** Media Access Control Address is often called "physical address" or "burned-in address". It is a sequence of two digit six numbers such as `9C-B6-D0-B6-DE-B3`. It is assigned to a network enabled device during manufacturing and usually does not change. In a LAN communication scenario we can use MAC address to identify the sender and the receiver of a particular message. However, they are not ideal for inter-network communication because MAC addresses are **flat** and unique to each device. For this reason we use more **hierarchical** systems for Internet communication.
* **The Internet/Network Layer** is the layer of protocols that are responsible for inter-network communication.
  *  **OSI's Network layer(3)** and **TCP/IP's Internet Layer(2)** serves this function.
  * The most commonly used protocol is **IP (The Internet Protocol)**. PDU of this layer is called **Data Packets**.
  * Primary functions of this layer are; Encapsulating data into **Packets**, and routing through **IP Addressing**

## IP address and a port number

* **IP address** are hierarchical compared to MAC addresses, and can be can be dynamically assigned to a device as it joins the network.
* The hierarchical logic of IP address works similar to post codes. This layered structure makes routing easier through finding the network first by searching if the IP address belongs to this network(network address). Machines on the same network share this address as part of their IP address. This is followed by an IP look-up to identify the device that message to be delivered to.
* There are two versions of IP addressing currently in use. **IPv4** and **IPv6**. The former is an earlier version put in use around 80s where as the latter one is developed mid 2000s to overcome the limititation in number of devices that IPv4 support.
* **


## DNS and how it works



## Client-server model of web interactions and the role of HTTP protocol within the model

# TCP & UDP
## TCP and UDP protocols, and their comparison
## Three-way handshake and its use
## Flow control and congestion avoidance

# URLs
## Components of URL, query strings
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
