resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.1/16"
  
}

resource "aws_subnet" "public_subnet_1" {
    cidr_block = "10.1.0.0/24"
    vpc_id = aws_vpc.my_vpc.id
  
}


resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.2.0.0./24"
  
}

resource "aws_internet_gateway" "my_ig" {
    vpc_id = aws_vpc.my_vpc.id
  
}

resource "aws_route_table" "public_table_1" {
    vpc_id = aws_vpc.my_vpc.id
    
  
}
resource "aws_route_table" "public_table_2" {
    vpc_id = aws_vpc.my_vpc.id
    
  
}

resource "aws_route" "route1" {
    route_table_id = aws_route_table.public_table_1.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  
}

resource "aws_route_table_association" "public_route" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_table_1.id
  
}

resource "aws_route_table_association" "public_route_2" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_table_2.id
  
}
