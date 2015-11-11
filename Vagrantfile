Vagrant.configure("2") do |config|
	config.vm.provider "docker" do |d|
	  	d.name = "elk"
	    d.build_dir = "."
	    d.vagrant_machine = "docker-host"
		d.vagrant_vagrantfile = "Vagrantfile.base"
	    d.ports = ["5601:5601"]
	end
end