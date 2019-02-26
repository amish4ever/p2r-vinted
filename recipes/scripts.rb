script_array = %w[store_mail.py get_mail.py]

script_array.each do |this_script|
  cookbook_file '/usr/sbin/' + this_script do
    source this_script
    mode 0o755
  end
end
