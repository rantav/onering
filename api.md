# API Documentation


## Intro

onering follows some common traditional REST patterns introduced by typical Ruby on Rails applications, so for example:

- you access resources such as `/physical_hosts` or `/datacenters`
- There are few common access points to each resource:
	- list (Get a list of all resources: `GET /resources`)
	- item (Get info about one resource: `GET /resources/:id`)
	- delete (Delete a resource: `DELETE /resources/:id`)
	- post (Create a new resource: `POST /resources`)
	- put (Update an existing resource: `PUT /resources`)
- each resource has a list url, such as `/physical_hosts` and an item url, such as `/physical_hosts/4f9e69ecf460e45f1900001e`
- To create new resources you `post` to `/physical_hosts`
- To delete a resource you send an HTTP `delete` to `/physical_hosts/:id`.
- By convention a `:id` is used to denote a resource ID
- To get a json formatted response you should add `.json` to the resource URL, for example `/physical_hosts/4f4b8545f460e470ec00054d.json`

## physical_hosts

### List all hosts

	curl http://localhost:5000/physical_hosts.json

### Details for host

	curl http://localhost:5000/physical_hosts/4f4b8545f460e470ec00054d.json

Or you could replace the ugly Object ID (4f4b8545f460e470ec00054d) with the resource name and get an easier to memorize name

	curl http://localhost:5000/physical_hosts/mysql12-dc1.json
Attention: Please make sure to replace all the `.` with `-`, for example the name `mysql12.dc1` was transformed to `mysql12-dc1`

### Create a new host
To create a new host you POST a JSON document like this:

	curl http://localhost:5000/physical_hosts.json -D - --header "Content-Type: application/json" -d '{"name": "my.server.com", "n": 1, "u": 1}'
Note that there is a set of minimal required attributes to keep the object valid, in this case it's the name, n and u

To Create a new host and associate it to a rack (not that this time most of the output is included):

	curl http://localhost:5000/physical_hosts.json -D - --header "Content-Type: application/json" -d '{"name": "my.server.com", "n": 1, "u": 1, "physical_rack_id": "4f4b859cf460e470ec0006dd"}'
	HTTP/1.1 201 Created
	Location: http://localhost:5000/physical_hosts/4f9e9af0f460e45f19000033

	{"_id":"4f9e9af0f460e45f19000033","_keywords":["519","amc","com","my","ord3","server"],"created_at":"2012-04-30T17:00:16+03:00","mac":null,"make":null,"model":null,"n":1,"name":"my.server.com","notes":null,"ob_name":null,"parent_host_id":null,"physical_rack_id":"4f4b859cf460e470ec0006dd","power_consumption":null,"serial":null,"status":null,"u":1,"updated_at":"2012-04-30T17:00:16+03:00"}

There are a few things to note here:

- The status 201 indicates successful creation of the new host
- The Location header lets you easily view this host 
- The json body of the response contains the details of the newly created resource


### Update a host
To update a host you send a PUT request to the host's resource URL, for example:

	curl http://localhost:5000/physical_hosts/4f9e9af0f460e45f19000033.json -X PUT -D - --header "Content-Type: application/json" -d '{"name": "my.other-server.com"}'         
	HTTP/1.1 200 OK

A 200 response means what you think it means :)


## physical_racks

TODO

## datacenters

TODO

