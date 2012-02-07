module ClassyBot

  def self.root
    File.expand_path(File.dirname(__FILE__) + '/../..')
  end

  # Default values for some classybot's parameters

  DEFAULTS = {
    :adapter    => 'pg',
    :username   => '',
    :password   => '',
    :host       => 'localhost',
    :database   => ''
  }

  Dir.glob(root + '/messages/*').each { |f|
    const_set File.basename(f).upcase, File.open(f).read.split("\n")
  }

  IMAGES = Dir.glob(root + '/images/tgif/*.jpg')

end
