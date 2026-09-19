-- Player web accounts. A player registers with their public CD key (proved
-- via a one-time in-game ".web" code -- see player_auth.php::player_register)
-- and a password; that password is unrelated to the CD key/game auth itself.
CREATE TABLE IF NOT EXISTS web_players (
    cdkey      VARCHAR(8)   NOT NULL,
    pass_hash  VARCHAR(255) NOT NULL,
    last_login TIMESTAMP    NULL DEFAULT NULL,
    created    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cdkey)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
