require 'timeout'

class FileQueue
  attr_accessor :write_count, :read_count, :prefix

  def initialize(prefix)
    @prefix = prefix
    @write_count = 1
    @read_count = 1
    clean_up
  end

  def clean_up
    clean_count = 1
    done = false
    while not done
      file_name = gen_file_name(clean_count)
      if File.exist?(file_name)
        File.delete(file_name)
        clean_count = clean_count + 1
      else
        done = true
      end
    end
  end

  def push(obj)
    safe_write do |file|
      file.write(obj)
    end
  end

  alias << push

  def pop
    value = nil
    safe_read do |file|
      value = file.gets
    end
    value
  end

  def length
    @write_count - @read_count
  end

  def empty?
    return length == 0
  end

  protected

  def safe_read
    file_name = gen_file_name(@read_count)
    return nil unless File.exist?(file_name)
    @read_count = @read_count + 1
    File.open(file_name, "r") do |file|
      yield file
    end
  end

  def safe_write
    file_name = gen_file_name(@write_count)
    if File.exist?(file_name)
      raise "#{file_name} already exists, cannot write"
    end
    @write_count = @write_count + 1
    File.open(file_name, "w") do |file|
      yield file
    end
  end

  def gen_file_name(count)
    __dir__ + "../log/#{@prefix}#{count}"
  end
end
