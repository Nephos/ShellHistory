class String

  # from https://github.com/Nephos/rubyhelper/
  def force_utf8 replace='?'
    raise ArgumentError, 'replace is not a valid char (String)' unless replace.is_a? String
    return self.encode('UTF-8', invalid: :replace, undef: :replace, replace: replace)
  end

end
