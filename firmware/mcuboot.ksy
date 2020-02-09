meta:
  id: mcuboot
  file-extension: mcuboot
  endian: le
seq:
  - id: header
    type: image_header
  - id: image
    size: header.img_size
  - id: tvl_header
    type: tvl_header
  - id: tlv_values
    type: tlv
    repeat: eos
types:
  image_header:
    seq:
      - id: magic
        contents: [0x3d, 0xb8, 0xf3, 0x96]
      - id: load_addr
        size: 4
      - id: header_size
        type: u2
        doc: Header size in bytes
      - id: tlv_size
        type: u2
        doc: TLV area size in bytes
      - id: img_size
        type: u4
        doc: Image size (without the header)
      - id: flags
        type: u4
        enum: image_flag
        doc: image flags
      - id: version
        type: image_version
      - id: padding
        size: header_size - 28
    enums:
      image_flag:
        1: icmp
        10: tcp
        20: udp
  image_version:
    seq:
      - id: major
        type: u1
      - id: minor
        type: u1
      - id: revision
        type: u2
      - id: build
        type: u4
  tvl_header:
    seq: 
      - id: magic
        contents: [0x07, 0x69]
      - id: tvl_size
        type: u2
        doc: Size of the TVL area (including the the header)
  tlv: 
    seq:
      - id: type
        type: u1
        enum: tlv_types
      - id: padding
        size: 1
      - id: len
        type: u2
      - id: value
        size: len
    enums:
      tlv_types:
        1: key_hash
        10: sha256
        20: rsa2048_pss
        21: ecdsa224
        22: ecdsa256
        23: rsa3072_pss
        24: ed25519
        30: enc_rsa2048
        31: enc_kw128
        32: enc_ec256
        40: dependency
