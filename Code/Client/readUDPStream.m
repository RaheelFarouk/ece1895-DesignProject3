%UDP Socket object
udpSocket1 = udpport("byte", "IPV4");

%udpSocket2 = udpport("byte", "IPV4");
%client = tcpclient("raheelfarouk.tplinkdns.com",20003)
serverAddress = "192.168.88.254";

% write to UDP Server
write(udpSocket1, "Add Me", "string", "192.168.88.254", 20003);
%write(client,"Add Me")

%Read data from UDP Server
while true
    udpData = readline(udpSocket1)
end
