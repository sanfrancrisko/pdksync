require 'fileutils'
require 'yaml'

def log(msg)
  File.open('module_prep.log', 'a') do |log|
    log.puts("[#{Time.now}]: #{msg}")
  end
end

managed_modules = YAML.safe_load(File.read('managed_modules.yml'))

managed_modules.each do |puppet_module|

  puppet_module_path = File.join('modules_pdksync', puppet_module)

  if Dir.exist?(puppet_module_path)
    log("Removing #{puppet_module_path}")
    FileUtils.rm_rf(puppet_module_path)
  end

  git_clone_cmd = "git clone https://github.com/puppetlabs/#{puppet_module} #{puppet_module_path}"
  log("Running #{git_clone_cmd}")
  `#{git_clone_cmd}`

end

git_clone_cmd = "rm -rf puppet && git clone https://github.com/puppetlabs/puppet"
log("Running #{git_clone_cmd}")
`#{git_clone_cmd}`
`sed -i 's/version = "7.0.0"/version = "6.99.9"/' puppet/.gemspec`
