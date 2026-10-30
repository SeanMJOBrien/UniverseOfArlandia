<?php
/**
* Sends BNES solicitation to an NWNEE server and receives a
* BNER response.
*
*  - error: string
*      When An error message hinting at the problem.
*
* The following keys are only defined when the query has
* succeeded
*
* - header: string
*      The BNER response header (which is always "BNER")
* - protocol: int
*      The BNER response protocol field
* - port: int
*      The BNER response port field (the port the server
*      listens on)
* - enumType: int
*      The BNER response enumType field
* - sessionNameSize: int
*      The size of the BNER response sessionName field
* - sessionName: string
*      The BNER sessionName field.  This can be considered
*      to be the name of the NWNEE server.
*
* @param $fp filepointer A filepointer for a udp stream to
*      a NWNEE server
* @param $timeout_int integer How long to wait for a response
*      from the NWNEE server before timing out
* @param $read_size_int integer How many bytes to read from the
*      NWNEE server response
* @return array A map of BNER response fields returned from the
*      NWNEE server
*/
function send_bnes_recv_bner(
    $fp,
    $timeout_int   = 2,
    $read_size_int = 5000
) {
    # Data structure borrowed from
    # https://github.com/niv/neverwinter_utils.nim/blob/master/src/packets.nim
    # commit 8374044cdc3e32b0a31b3c5a4dd4b784be947326
    # BNES* = object
    #   header: StaticValue["BNES"]
    #   port: uint16
    #   enumType: uint8
    $bnes_bstr = pack(
        # string of length 4
        "aaaa" .
        # unsigned short, little endian
        "v"    .
        # unsigned char
         "C"   ,
        # header
        'B', 'N', 'E', 'S',
        # port
        0x0000,
        # enumType
        0x00
    );
    $write     = fwrite($fp, $bnes_bstr);
    $timeout   = stream_set_timeout($fp, $timeout_int);
    $bner_bstr = fread($fp, $read_size_int);
    if (!$write) {
        return array(
            'error' => "Error al escribir en el servidor"
        );
    }
    if (!$timeout) {
        return array(
            'error' => "Timeout (${timeout_int}s) " .
                "expiró esperando respuesta"
        );
    }
    if (!$bner_bstr) {
        return array(
            'error' => "Respuesta vacía del servidor"
        );
    }
    # Data structure borrowed from
    # https://github.com/niv/neverwinter_utils.nim/blob/master/src/packets.nim
    # commit 8374044cdc3e32b0a31b3c5a4dd4b784be947326
    # BNER* = object
    #   header: StaticValue["BNER"]
    #   protocol: uint8
    #   port: uint16
    #   enumType: uint8
    #   sessionName: SizePrefixedString[uint8]
    $bner_array = unpack(    
        # string of length 4
        "a4" . "header"            . "/" .
        # unsigned char
        "C"  . "protocol"          . "/" .
        # unsigned short, little endian
        "v"  . "port"              . "/" .
    # unsigned char
        "C"  . "enumType"          . "/" .
    # unsigned char
        "C"  . "sessionNameSize"         ,
        $bner_bstr
    );
    # Create the unpack format string for retrieving
    # the "sessionName"
    $fmt = "a" . strval($bner_array['sessionNameSize']);
    $bner_array = unpack(    
        "a4" . "header"            . "/" .
        "C"  . "protocol"          . "/" .
        "v"  . "port"              . "/" .
        "C"  . "enumType"          . "/" .
        "C"  . "sessionNameSize"   . "/" .
        $fmt . "sessionName"             ,
        $bner_bstr
    );
    return($bner_array);
}
/**
* Sends BNLM solicitation to an NWNEE server and receives a
* BNLR response.
*
*  - error: string
*      When An error message hinting at the problem.
*
* The following keys are only defined when the query has
* succeeded
*
* - header: string
*      The BNLR response header (which is always "BNLR")
* - port: int
*      The BNLR response port field (the port the server
*      listens on)
* - messageNo: int
*      The BNLR response messageNo field
* - sessionId: int
*      The BNLR sessionId response field
*
* @param $fp filepointer A filepointer for a udp stream to
*      a NWNEE server
* @param $timeout_int integer How long to wait for a response
*      from the NWNEE server before timing out
* @param $read_size_int integer How many bytes to read from the
*      NWNEE server response
* @return array A map of bnlr response fields returned from the
*      NWNEE server
*/
function send_bnlm_recv_bnlr(
    $fp,
    $timeout_int   = 2,
    $read_size_int = 5000
) {
    # Data structure borrowed from
    # https://github.com/niv/neverwinter_utils.nim/blob/master/src/packets.nim
    # commit 8374044cdc3e32b0a31b3c5a4dd4b784be947326
    # BNLM* = object
    #   header: StaticValue["BNLM"]
    #   port: uint16
    #   messageNo: uint8
    #   sessionId: uint32
    $bnlm_bstr = pack(
        # string of length 4
        "aaaa" .
        # unsigned short, little endian
        "v"    .
        # unsigned char
        "C"    .
        # unsigned long, little endian
        "V"    ,
        # header
        'B', 'N', 'L', 'M',
        # port
        0x0000,
        # messageNo
        0x01,
        # sessionId
        0x00000000
    );
    $write     = fwrite($fp, $bnlm_bstr);
    $timeout   = stream_set_timeout($fp, $timeout_int);
    $bnlr_bstr = fread($fp, $read_size_int);
    if (!$write) {
        return array(
            'error' => "Error al escribir en el servidor"
        );
    }
    if (!$timeout) {
        return array(
            'error' => "Timeout (${timeout_int}s) " .
                "expiró esperando respuesta"
        );
    }
    if (!$bnlr_bstr) {
        return array(
            'error' => "Respuesta vacía del servidor"
        );
    }
    # Data structure borrowed from
    # https://github.com/niv/neverwinter_utils.nim/blob/master/src/packets.nim
    # commit 8374044cdc3e32b0a31b3c5a4dd4b784be947326
    # BNLR* = object
    #   header: StaticValue["BNLR"]
    #   port: uint16
    #   messageNo: uint8
    #   sessionId: uint32
    $bnlr_array = unpack(    
        # string of length 4
        "a4" . "header"            . "/" .
        # unsigned short, little endian
        "v"  . "port"              . "/" .
    # unsigned char
        "C"  . "messageNo"         . "/" .
    # unsigned char
        "V"  . "sessionId"               ,
        $bnlr_bstr
    );
    return($bnlr_array);
}
/**
* Sends BNDS solicitation to an NWNEE server and receives a
* BNDR response.
*
*  - error: string
*      When An error message hinting at the problem.
*
* The following keys are only defined when the query has
* succeeded
*
* - header: string
*      The BNDR response header (which is always "BNDR")
* - port: int
*      The BNDR response port field (the port the server
*      listens on)
* - serverDescriptionSize: int
*      The size of the BNDR response serverDescription field
* - serverDescription: string
*      The BNDR serverDescription field
* - moduleDescriptionSize: int
*      The size of the BNDR response moduleDescription field
* - moduleDescription: string
*      The BNDR moduleDescription field
* - serverVersionSize: int
*      The size of the BNDR response serverVersion field
* - serverVersion: string
*      The BNDR serverVersion field
*
* @param $fp filepointer A filepointer for a udp stream to
*      a NWNEE server
* @param $timeout_int integer How long to wait for a response
*      from the NWNEE server before timing out
* @param $read_size_int integer How many bytes to read from the
*      NWNEE server response
* @return array A map of BNER response fields returned from the
*      NWNEE server
*/
function send_bnds_recv_bndr(
    $fp,
    $timeout_int   = 2,
    $read_size_int = 5000
) {
    # Data structure borrowed from
    # https://github.com/niv/neverwinter_utils.nim/blob/master/src/packets.nim
    # commit 8374044cdc3e32b0a31b3c5a4dd4b784be947326
    # BNDS* = object
    #   header: StaticValue["BNDS"]
    #   port: uint16
    $bnds_bstr = pack(
        # string of length 4
        "aaaa" .
        # unsigned short, little endian
        "v"    ,
        # header
        'B', 'N', 'D', 'S',
        # port
        0x0000
    );
    $write     = fwrite($fp, $bnds_bstr);
    $timeout   = stream_set_timeout($fp, $timeout_int);
    $bndr_bstr = fread($fp, $read_size_int);
    if (!$write) {
        return array(
            'error' => "Error al escribir en el servidor"
        );
    }
    if (!$timeout) {
        return array(
            'error' => "Timeout (${timeout_int}s) " .
                "expiró esperando respuesta"
        );
    }
    if (!$bndr_bstr) {
        return array(
            'error' => "Respuesta vacía del servidor"
        );
    }
    # Data structure borrowed from
    # https://github.com/niv/neverwinter_utils.nim/blob/master/src/packets.nim
    # commit 8374044cdc3e32b0a31b3c5a4dd4b784be947326
    # BNDR* = object
    #   header: StaticValue["BNDR"]
    #   port: uint16
    #   serverDescription: SizePrefixedString[uint32]
    #   moduleDescription: SizePrefixedString[uint32]
    #   serverVersion: SizePrefixedString[uint32]
    #   gameType: uint16
    # First pass - get serverDescriptionSize
    $bndr_array = unpack(    
        # string of length 4
        "a4" . "header"                . "/" .
        # unsigned short, little endian
        "v"  . "port"                  . "/" .
        # unsigned short, little endian
        "V"  . "serverDescriptionSize"       ,
        $bndr_bstr
    );
    # Create the unpack format string for retrieving
    # the "serverDescription"
    $sd_fmt = "a" . strval(
        $bndr_array['serverDescriptionSize']
    );
    # Second pass - get serverDescription and
    # moduleDescriptionSize
    $bndr_array = unpack(    
        "a4"    . "header"                . "/" .
        "v"     . "port"                  . "/" .
        "V"     . "serverDescriptionSize" . "/" .
        $sd_fmt . "serverDescription"     . "/" .
        "V"     . "moduleDescriptionSize"       ,
        $bndr_bstr
    );
    # Create the unpack format string for retrieving
    # the "moduleDescription"
    $md_fmt = "a" . strval(
        $bndr_array['moduleDescriptionSize']
    );
    # Third pass - get moduleDescription and
    # serverVersionSize
    $bndr_array = unpack(    
        "a4"    . "header"                . "/" .
        "v"     . "port"                  . "/" .
        "V"     . "serverDescriptionSize" . "/" .
        $sd_fmt . "serverDescription"     . "/" .
        "V"     . "moduleDescriptionSize" . "/" .
        $md_fmt . "moduleDescription"     . "/" .
        "V"     . "serverVersionSize"           ,
        $bndr_bstr
    );
    # Create the unpack format string for retrieving
    # the "moduleDescription"
    $sv_fmt = "a" . strval(
        $bndr_array['serverVersionSize']
    );
    # Fourth pass - get serverVersion
    $bndr_array = unpack(    
        "a4"    . "header"                . "/" .
        "v"     . "port"                  . "/" .
        "V"     . "serverDescriptionSize" . "/" .
        $sd_fmt . "serverDescription"     . "/" .
        "V"     . "moduleDescriptionSize" . "/" .
        $md_fmt . "moduleDescription"     . "/" .
        "V"     . "serverVersionSize"     . "/" .
        $sv_fmt . "serverVersion"         . "/" .
        "v"     . "gameType"                    ,
        $bndr_bstr
    );
    return($bndr_array);
}
/**
* Sends BNXI solicitation to an NWNEE server and receives a
* BNXR response.
*
*  - error: string
*      When An error message hinting at the problem.
*
* The following keys are only defined when the query has
* succeeded
*
* - header: string
*      The BNXR response header (which is always "BNXR")
* - port: int
*      The BNXR response port field (the port the server
*      listens on)
* - bnxiVersionNumber: int
*      The BNXR bnxiVersionNumber field
* - hasPassword: int
*      The BNXR hasPassword field
* - minLevel: int
*      The BNXR response minLevel field - the minimum level of
*      PCs on the server
* - maxLevel: int
*      The BNXR response maxLevel field - the maximum level of
*      PCs on the server
* - currentPlayers: int
*      The BNXR response currentPlayers field - the number of
*      PCs currently logged into the server
* - maxPlayers: int
*      The BNXR response maxPlayers field - the maximum number
*      of PCs allowed on the server
* - vaultMode: int
*      The BNXR response vaultMode field
* - pvp: int
*      The BNXR response pvp field
* - playerPause: int
*      The BNXR response playerPause field
* - oneParty: int
*      The BNXR response oneParty field
* - elc: int
*      The BNXR response elc field
* - ilr: int
*      The BNXR response ilr field
* - xp: int
*      The BNXR response ilr field
* - moduleName: int
*      The BNXR response moduleName field
*
* @param $fp filepointer A filepointer for a udp stream to
*      a NWNEE server
* @param $timeout_int integer How long to wait for a response
*      from the NWNEE server before timing out
* @param $read_size_int integer How many bytes to read from the
*      NWNEE server response
* @return array A map of BNER response fields returned from the
*      NWNEE server
*/
function send_bnxi_recv_bnxr(
    $fp,
    $timeout_int   = 2,
    $read_size_int = 5000
) {
    # Data structure borrowed from
    # https://github.com/niv/neverwinter_utils.nim/blob/master/src/packets.nim
    # commit 8374044cdc3e32b0a31b3c5a4dd4b784be947326
    # BNXI* = object
    #   header: StaticValue["BNXI"]
    #   port: uint16
    $bnxi_bstr = pack(
        # string of length 4
        "aaaa" .
        # unsigned short, little endian
         "v"   ,
        # header
        'B', 'N', 'X', 'I',
        # port
        0x0000
    );
    $write     = fwrite($fp, $bnxi_bstr);
    $timeout   = stream_set_timeout($fp, $timeout_int);
    $bnxr_bstr = fread($fp, $read_size_int);
    if (!$write) {
        return array(
            'error' => "Error al escribir en el servidor"
        );
    }
    if (!$timeout) {
        return array(
            'error' => "Timeout (${timeout_int}s) " .
                "expiró esperando respuesta"
        );
    }
    if (!$bnxr_bstr) {
        return array(
            'error' => "Respuesta vacía del servidor"
        );
    }
    # Data structure borrowed from
    # https://github.com/niv/neverwinter_utils.nim/blob/master/src/packets.nim
    # commit 8374044cdc3e32b0a31b3c5a4dd4b784be947326
    # BNXR* = object
    #   header: StaticValue["BNXR"]
    #   port: uint16
    #   bnxiVersionNumber: uint8
    #   hasPassword: uint8
    #   minLevel: uint8
    #   maxLevel: uint8
    #   currentPlayers: uint8
    #   maxPlayers: uint8
    #   vaultMode: uint8
    #   pvp: uint8
    #   playerPause: uint8
    #   oneParty: uint8
    #   elc: uint8
    #   ilr: uint8
    #   xp: uint8
    #   moduleName: SizePrefixedString[uint8]
    $bnxr_array = unpack(    
        # string of length 4
        "a4" . "header"            . "/" .
        # unsigned short, little endian
        "v"  . "port"              . "/" .
    # unsigned char
        "C"  . "bnxiVersionNumber" . "/" .
    # unsigned char
        "C"  . "hasPassword"       . "/" .
    # unsigned char
        "C"  . "minLevel"          . "/" .
    # unsigned char
        "C"  . "maxLevel"          . "/" .
    # unsigned char
        "C"  . "currentPlayers"    . "/" .
    # unsigned char
        "C"  . "maxPlayers"        . "/" .
    # unsigned char
        "C"  . "vaultMode"         . "/" .
    # unsigned char
        "C"  . "pvp"               . "/" .
    # unsigned char
        "C"  . "playerPause"       . "/" .
    # unsigned char
        "C"  . "oneParty"          . "/" .
    # unsigned char
        "C"  . "elc"               . "/" .
    # unsigned char
        "C"  . "ilr"               . "/" .
    # unsigned char
        "C"  . "xp"                . "/" .
    # unsigned char
        "C"  . "moduleNameSize"          ,
        $bnxr_bstr
    );
    # Create the unpack format string for retrieving
    # the "moduleName"
    $fmt = "a" . strval($bnxr_array['moduleNameSize']);
        
    $bnxr_array = unpack(    
        "a4" . "header"            . "/" .
        "v"  . "port"              . "/" .
        "C"  . "bnxiVersionNumber" . "/" .
        "C"  . "hasPassword"       . "/" .
        "C"  . "minLevel"          . "/" .
        "C"  . "maxLevel"          . "/" .
        "C"  . "currentPlayers"    . "/" .
        "C"  . "maxPlayers"        . "/" .
        "C"  . "vaultMode"         . "/" .
        "C"  . "pvp"               . "/" .
        "C"  . "playerPause"       . "/" .
        "C"  . "oneParty"          . "/" .
        "C"  . "elc"               . "/" .
        "C"  . "ilr"               . "/" .
        "C"  . "xp"                . "/" .
        "C"  . "moduleNameSize"    . "/" .
        $fmt . "moduleName"              ,
        $bnxr_bstr
    );
    return($bnxr_array);
}
?>
