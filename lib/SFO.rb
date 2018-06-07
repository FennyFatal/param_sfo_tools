require "bindata"

class SFO
  def self.transform_data(key,data)
    case key
    when :SYSTEM_VER
      disp_as_hex data
    when :PUBTOOLVER
      disp_as_hex data
    when :REMOTE_PLAY_KEY_ASSIGN
      disp_as_hex data
    when :DOWNLOAD_DATA_SIZE
      disp_as_hex data
    when :APP_TYPE
      disp_as_hex data
    when :PARENTAL_LEVEL
      disp_as_hex data
    when :PT_PARAM
      disp_as_hex data
    when :DEV_FLAG
      disp_as_hex data
    when :PUBTOOLMINVER
      disp_as_hex data
    when :ATTRIBUTE
      Attribute.read(data.to_binary_s.reverse)
    when :ATTRIBUTE2
      Attribute2.read(data.to_binary_s.reverse)
    else
      data.to_binary_s.strip
    end
  end

  def self.disp_as_hex(item)
    item.to_binary_s.reverse.unpack('H*')[0]
  end
  
  class Attribute < BinData::Record
    bit1 :display_location_flag
    bit1 :unknown_value_15
    bit1 :supports_HDR
    bit1 :unknown_value_14
    bit1 :unknown_value_13
    bit1 :requires_PSVR
    bit1 :unknown_value_12
    bit1 :unknown_value_11
    bit1 :support_NEO_mode_on_PRO
    bit1 :unknown_value_10
    bit1 :unknown_value_9
    bit1 :unknown_value_8
    bit1 :unknown_value_7
    bit1 :unknown_value_6
    bit1 :unknown_value_5
    bit1 :cpu_mode_7cpu
    bit1 :cpu_mode_6cpu
    bit1 :psvr_support
    bit1 :unknown_value_4
    bit1 :unknown_value_3
    bit1 :unknown_value_2
    bit1 :hdcp_disalbed_non_games
    bit1 :hdcp_enabled
    bit1 :suspend_on_output_resolution_change
    bit1 :unknown_value_1
    bit1 :share_button_overriden
    bit1 :common_dialog_accept_system_setting
    bit1 :suspend_on_lose_focus
    bit1 :stereoscopic_3d
    bit1 :ps_move
    bit1 :common_dialog_accept_is_cross
    bit1 :support_logout    
  end

  class Attribute2 < BinData::Record
    bit1 :unknown_value_24
    bit1 :unknown_value_23
    bit1 :unknown_value_22
    bit1 :unknown_value_21
    bit1 :unknown_value_20
    bit1 :unknown_value_19
    bit1 :unknown_value_18
    bit1 :unknown_value_17
    bit1 :unknown_value_16
    bit1 :unknown_value_15
    bit1 :unknown_value_14
    bit1 :unknown_value_13
    bit1 :unknown_value_12
    bit1 :unknown_value_11
    bit1 :unknown_value_10
    bit1 :unknown_value_9
    bit1 :unknown_value_8
    bit1 :unknown_value_7
    bit1 :unknown_value_6
    bit1 :support_team_on_team_tournament_sdk4500
    bit1 :support_one_on_one_match_sdk3500
    bit1 :unknown_value_5
    bit1 :does_not_apply_dummy_psmove_tracking_to_cpu
    bit1 :support_broadcase_separate_mode
    bit1 :unknown_value_4
    bit1 :unknown_value_3
    bit1 :psvr_eye_setting_dynamic_config
    bit1 :psvr_personal_eye_setting_disabled
    bit1 :unknown_value_2
    bit1 :support_content_search
    bit1 :support_video_recording
    bit1 :unknown_value_1
  end
  
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
      #many of these should be little endian values, but we reverse byte order later.
      array :data, :type => :uint8, :read_abs_offset => lambda {index_entries[index]}, :initial_length => lambda {index_entries[index].data_max_len}
    end
  end

  #Takes a stream as an argument
  def self.parse_sfo(stream)
    sfo = read(stream)
    unless sfo.header.magic == 1179865088
      return nil
    end
    sfoHash = Hash[sfo.key_table.zip(sfo.data_table)].inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    sfoHash.each_key do |key|
      sfoHash[key] = transform_data(key,sfoHash[key])
    end
    sfoHash
  end
end
