class IPDetection

  puts "Problem:A network router is a device which knows where to send which packet,.
        So if we define that any packet for network address 1.1.1.1 to be sent to network
        device A, so it will forward every packet for 1.1.1.1 to device A. Apart from these
        rules a network router has a default gateway defined, so if a packet does not match
        any rule it will send that to default gateway.A network rule is defined by providing
        an IP Address followed by their netmask and a destination machine, at the end
        followed by default gateway (optional).You need to write a simple router simulator,
        which will be take input in terms of number of routing rules followed by routing
        rules and then number of route statements and followed by route statements. Your
        output will be routed destination and if it can not route some packets then
        output should print NO ROUTE DEFINED."

  puts "Problem\'s Solution:"
  puts "Enter the number of routing rules you need to define."
  num = gets.chomp!.to_i
  puts "Please enter the rule in the format IP Address followed by their netmask and a destination machine"
  puts "example for specifying the IP with subnet-mask and gateway: 10.0.0.0 255.255.255.0 192.168.1.1 "
  puts "example for specifying the default gateway: default 192.168.1.3 "
  rules=[]
  i = 0
  until i==num
    puts "Please enter Rule #{i+1}"
    rule = gets.chomp
    rules << rule
    i+=1
  end
  rules.each_with_index do |rule,index|
  puts "Rule #{index+1}. #{rule}"
  end
  rule_ip =  []
  rule_subnet = []
  rule_gateway= []
  rules.each do |rule|
  rule_ip << rule.split(' ')[0]
  rule_subnet << rule.split(' ')[1]
  rule_gateway << rule.split(' ')[2]
  end
  def self.validate_ip(index,ip,r_ip,rule_subnet,r_index)
    if r_ip.split('.')[index].to_i != 0 && rule_subnet[r_index].split('.')[index] != 0
      ip.split('.')[index].to_i.between?(0,255-rule_subnet[r_index].split('.')[index].to_i) && ip.split('.')[index].to_i.between?(0,r_ip.split('.')[index].to_i)
    elsif r_ip.split('.')[index].to_i == 0 && rule_subnet[r_index].split('.')[index] == 0
      ip.split('.')[index].to_i.between?(0,255)
    elsif r_ip.split('.')[index].to_i != 0 && rule_subnet[r_index].split('.')[index] == 0
      ip.split('.')[index].to_i.between?(0,255) && ip.split('.')[index].to_i.between?(0,r_ip.split('.')[index].to_i)
    elsif r_ip.split('.')[index].to_i == 0 && rule_subnet[r_index].split('.')[index] != 0
      ip.split('.')[index].to_i.between?(0,255-rule_subnet[r_index].split('.')[index].to_i)
    end
  end
  def self.calc_gateway(ip,rule_ip,rule_subnet,rule_gateway)
    rule_ip_first = []
    rule_ip.each do |ru_ip|
      rule_ip_first << ru_ip.split('.').first
    end
    error = []
    rule_ip.each_with_index do |r_ip,r_index|
      if r_ip.split('.').first.to_i == ip.split('.').first.to_i &&
          validate_ip(1,ip,r_ip,rule_subnet,r_index) &&
          validate_ip(2,ip,r_ip,rule_subnet,r_index) &&
          validate_ip(3,ip,r_ip,rule_subnet,r_index)
        puts  "Gateway for this #{ip} is #{rule_gateway[r_index]}"
      elsif rule_ip_first.include?(ip.split('.').first)
        error <<  (rule_ip.last.split(' ').first == "default" ? "default gateway #{rule_subnet.last} for IP #{ip}" : "No route defined")
        puts error.uniq!
      end
    end
  end

  puts "Enter the number of packets you want to transfer"
  pack_num = gets .chomp!.to_i
  puts "#{pack_num} Packets getting transferred"
  j = 0
  until j==pack_num
    puts "#{j+1}. Packet IP"
    ip = gets.chomp!
    calc_gateway(ip,rule_ip,rule_subnet,rule_gateway)
    j+=1
  end

end
