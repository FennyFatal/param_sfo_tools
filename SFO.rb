require "bindata"

class SFO

  class Header < BinData::Record
    uint32le :magic
    uint32le :version
    uint32le :key_table_start
    uint32le :data_table_start
    uint32le :tables_entries
  end

  class Sfo_index_table_entry < BinData::Record
    uint16le :key_offset
    uint16le :data_fmt
    uint32le :data_len
    uint32le :data_max_len
    uint32le :data_offset
  end

  class SFO < BinData::Record
    endian :little
    Header :header
    array  :index_entries, :type => Sfo_index_table_entry, :initial_length => lambda { header.tables_entries }
    array :key_table, :type => :stringz, :initial_length => lambda { header.tables_entries }
    array :data_table, :initial_length => lambda { header.tables_entries }, :byte_align => 4 do
      array :data, :type => :uint8, :read_abs_offset => lambda {index_entries[index]}, :initial_length => lambda {index_entries[index].data_max_len}
    end
  end

  #Takes a stream as an argument
  def self.parse_sfo(stream)
    sfo = SFO.read(stream)
    unless sfo.header.magic == 1179865088
      return nil
    end
    Hash[sfo.key_table.zip(sfo.data_table)].inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end
end
