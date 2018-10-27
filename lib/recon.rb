# frozen_string_literal: true

require "thor"
require 'date'
require 'tmpdir' # Not needed if you are using rails.

class Recon < Thor
  include Thor::Actions

  def self.source_root
  end


  desc "waf_fp TARGET", "Web-Application Fingerprint"
  def waf_fp(target)
  	`nmap -p80,443 --script http-waf-fingerprint #{target}`
  end

  desc "waf_det", "Web-Application Firewall Detect"
  def waf_det(target)
  	`nmap -p80,443 --script http-waf-detect --script-args="http-waf-detect.aggro,http-waf-detect.detectBodyChanges" #{target}`
  end

    desc "list_scripts", "Web-Application Fingerprint"
  def waf_fp(target)
  	`nmap -p80,443 --script http-waf-fingerprint #{target}`
  end

  desc "install_libs DIR", "Installing Vulscan and Vulners"
  def waf_det(dir='/usr/share/nmap/scripts/')
  	`git clone https://github.com/vulnersCom/nmap-vulners.git #{File.join(target, 'vulners')`
  	`git clone https://github.com/scipag/vulscan.git #{File.join(target, 'vulscan')}`
  	`vulscan/utilities/updater/`
  	`chmod +x updateFiles.sh`
  	`./updateFiles.sh`
  end

  desc "list_vulscan", "List VulScan Scripts"
  def list_vulscan
  	`ls vulscan/*.csv`
  end

  desc "list_vulners", "List Vulners Scripts"
  def list_vulners
  	`ls vulners/*.csv`
  end

  desc "vulners TARGET", "Vulners Scan"
  def vulners(target)
  	`proxychains nmap --script nmap-vulners -oX /root/nmap-vulners.xml -sV  #{target}`
  	`#{msf('--script nmap-vulners --proxy socks4://127.0.0.1:9050 -sV 104.219.250.6')}`
  	
  end

  desc "vulscan", "Vulscan"
  def vulscan(target)
  	`proxychains nmap --script vulscan -oX /root/nmap-vulscan.xml -sV  #{target}`
  end

    desc "http_errors TARGET", "Web-Application HTTP Errors"
  def http_errors(target)
  	`nmap -p80,443 --script http-errors #{target}`
  end
  	    desc "full_scan TARGET", "Web-Application Full Scan"
  def full_scan(target)
  	`nmap --script nmap-vulners,vulscan -v --script-args vulscandb=scipvuldb.csv -oX /root/nmap-full.xml -sV ${target}`
  end

  desc "http_errors TARGET", "Web-Application Fingerprint"
  def http_errors(target)
  	`nmap -p80,443 --script http-errors #{target}`

  desc "http_errors TARGET", "Web-Application Fingerprint"
  def http_errors(target)
  	`nmap -p80,443 -v --script http-errors #{target}`
  end

  def proxychain(cmd)
  	'proxychain #{cmd}'
  end

  def msf_nmap(cmd)
  	'msfconsole -X db_nmap --proxy socks4://127.0.0.1:9050 #{cmd}'
  end

  def msf(cmd)
  	`mfsconsole -X #{cmd}`
  end


  

end
