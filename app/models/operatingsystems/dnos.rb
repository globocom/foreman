class DNOS < Operatingsystem
  # No automatic downloading, please copy DNOS images to
  # 'boot' direcotory in the TFTP server. Note that image
  # files must be named DNOS-$release-$version.bin.
  # Set $release and $version in the OS properties.
  PXEFILES = {}

  # Simple output of the media url
  def mediumpath(host)
    medium_uri(host).to_s
  end

  def class
    Operatingsystem
  end

  # The variant to use when communicating with the proxy. We need a new type here.
  def pxe_variant
    "bmp"
  end

  # The kind of PXE configuration template used. BMP is used for Dell BMP scripts.
  def template_kind
    "BMP"
  end

  def pxedir
    "none"
  end

  def url_for_boot(file)
    raise ::Foreman::Exception.new(N_("Function not available for %s"), self.display_family)
  end

  # where to create the boot file on the TFTP server
  def boot_filename(host = nil)
    "boot/FTOS#{('-' + host.host.architecture) unless host.host.architecture.blank?}-#{release}.bin"
  end

  def kernel(arch)
    "none"
  end

  def initrd(arch)
    "none"
  end

  # release_name can be used to complete image filenames
  def use_release_name?
    true
  end

  # release_name can have upper case letters and we want to keep it that way
  def downcase_release_name
    release_name
  end

  # generate a DNOS release number using release_name as a prefix,
  # in the format "$release_name-$version"
  def release
    "#{major}#{('.' + minor.to_s) unless minor.blank?}#{("." + release_name) unless release_name.blank?}"
  end

  def display_family
    "DNOS"
  end
end
