require 'json'

def process(content)
  content = process_double_back_slash content
  content = process_set content
  content = process_single_back_slack_mark content
  content = process_dollar_dollar content
  content = process_dollar content
  content
end

def process_double_back_slash(content)
  # \\ -> \\\\
  content.gsub(' \\\\', ' \\\\\\\\\\\\\\\\')
end

def process_set(content)
  # \{ \} -> \\{ \\}
  content = content.gsub('\\{', '\\\\\\\\{')
  content = content.gsub('\\}', '\\\\\\\\}')
  content
end

def process_single_back_slack_mark(content)
  # \# -> \\#
  # \! -> \\!
  # \; -> \\;
  content = content.gsub('\\#', '\\\\\\\\#')
  content = content.gsub('\\!', '\\\\\\\\!')
  content = content.gsub('\\;', '\\\\\\\\;')
  content
end

def process_dollar_dollar(content)
  # $$-$$
  parts = content.split("$$")
  ret = ""
  paren = ['\\\\[ ', ' \\\\]']
  parts.size.times {|i|
    if i % 2 == 1  # in math
      ret += process_inner_math_underscore parts[i]
    else
      ret += parts[i]
    end
    if i < parts.size - 1
      ret += paren[i % 2]
    end
  }
  ret
end

def process_dollar(content)
  # $-$
  parts = content.split("$")
  ret = ""
  paren = ['\\\\( ', ' \\\\)']
  parts.size.times {|i|
    if i % 2 == 1  # in math
      ret += process_inner_math_underscore parts[i]
    else
      ret += parts[i]
    end
    if i < parts.size - 1
      ret += paren[i % 2]
    end
  }
  ret
end

def process_inner_math_underscore(content)
  # _ -> \_
  content.gsub('_', '\\_')
end

def replace(book)
  if book.is_a? Array
    book.map {|item| replace item }
  elsif book["sections"]
    book["sections"] = book["sections"].map {|item| replace item}
    book
  elsif book["Chapter"] and book["Chapter"]["content"]
    book["Chapter"]["content"] = process(book["Chapter"]["content"])
    if book["Chapter"]["sub_items"]
      book["Chapter"]["sub_items"] = replace(book["Chapter"]["sub_items"])
    end
    book
  else
    STDERR.puts "Unknown data: #{book}"
  end
end

buf = STDIN.read
exit if buf.size == 0
_, book = JSON.parse buf
book = replace book
# STDERR.puts JSON.generate book
puts JSON.generate book
