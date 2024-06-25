
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


DROP SCHEMA IF EXISTS GlobalProtests;
CREATE SCHEMA IF NOT EXISTS GlobalProtests;


USE GlobalProtests;

CREATE TABLE if not exists cause (
    cause_id INT UNIQUE NOT NULL,
    cause_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (cause_id)
);

CREATE TABLE if not exists country (
    year INT,
    country VARCHAR(80) UNIQUE NOT NULL,
    protests_per_capita FLOAT, 
    population INT,
    gdp_per_capita FLOAT,
    unemployment_rate FLOAT,
    urbanization_rate FLOAT,
    inflation_rate FLOAT,
    region VARCHAR(80),
    PRIMARY KEY(country)
);

CREATE TABLE if not exists users (
    user_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    country VARCHAR(80) NOT NULL,
    user_type VARCHAR(20) NOT NULL,
    party VARCHAR(80),
    FOREIGN KEY (country) references country(country),
    PRIMARY KEY(user_id)
);

CREATE TABLE if not exists protests (
    protest_id INT UNIQUE NOT NULL AUTO_INCREMENT,
    location VARCHAR(80) NOT NULL,
    date DATE NOT NULL,
    description TEXT,
    violent BOOL NOT NULL,
    created_by INT,
    country VARCHAR(80) NOT NULL,
    cause INT NOT NULL,
    longitude FLOAT,
    latitude FLOAT,
    PRIMARY KEY (protest_id),
    FOREIGN KEY (created_by) references users(user_id),
    FOREIGN KEY (country) references country(country),
    FOREIGN KEY (cause) references cause(cause_id)
);


CREATE TABLE if not exists news_articles (
    news_id INT UNIQUE NOT NULL,
    article_name VARCHAR(100) NOT NULL,
    author_first_name VARCHAR(50) NOT NULL,
    author_last_name VARCHAR(50) NOT NULL,
    publication_date DATE,
    source VARCHAR(80),
    PRIMARY KEY (news_id)
);

CREATE TABLE if not exists posts (
    post_id INT UNIQUE NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    creation_date DATE NOT NULL,
    text TEXT,
    created_by INT NOT NULL,
    cause INT NOT NULL,
    PRIMARY KEY(post_id),
    FOREIGN KEY (created_by) references users(user_id),
    FOREIGN KEY (cause) references cause(cause_id)
);

CREATE TABLE if not exists comments (
    comment_id INT UNIQUE NOT NULL,
    created_by INT NOT NULL,
    post INT NOT NULL,
    text TEXT NOT NULL,
    created_at DATE,
    FOREIGN KEY (post) references posts(post_id) ON DELETE CASCADE,
    PRIMARY KEY (comment_id) # --not sure why i had post and comment_id as a double primary key?
);

CREATE TABLE if not exists protest_attendence (
    user INT,
    protest INT,
    FOREIGN KEY (user) references users(user_id),
    FOREIGN KEY (protest) references protests(protest_id) ON DELETE CASCADE
);

CREATE TABLE if not exists protest_likes (
    user INT,
    protest INT,
    FOREIGN KEY (user) references users(user_id),
    FOREIGN KEY (protest) references protests(protest_id) ON DELETE CASCADE
);

CREATE TABLE if not exists news_likes(
    user INT,
    news_article INT,
    FOREIGN KEY (user) references users(user_id),
    FOREIGN KEY (news_article) references news_articles(news_id)
);

CREATE TABLE if not exists user_interests (
    user INT,
    interests VARCHAR(100),
    FOREIGN KEY (user) references users(user_id)
);

CREATE TABLE IF NOT EXISTS model1_lobf_coefficients(
    sequence_number INTEGER AUTO_INCREMENT PRIMARY KEY,
    beta_0 FLOAT,
    beta_1 FLOAT,
    beta_2 FLOAT,
    beta_3 FLOAT,
    beta_4 FLOAT,
    beta_5 FLOAT,
    beta_6 FLOAT,
    beta_7 FLOAT,
    beta_8 FLOAT,
    beta_9 FLOAT,
    beta_10 FLOAT,
    beta_11 FLOAT,
    beta_12 FLOAT,
    beta_13 FLOAT,
    beta_14 FLOAT,
    beta_15 FLOAT,
    beta_16 FLOAT,
    beta_17 FLOAT,
    beta_18 FLOAT,
    beta_19 FLOAT,
    beta_20 FLOAT,
    beta_21 FLOAT,
    beta_22 FLOAT
);

CREATE TABLE IF NOT EXISTS model1_coefficients(
    sequence_number INTEGER AUTO_INCREMENT PRIMARY KEY,
    beta_vals varchar(100)
);

CREATE TABLE if not exists real_data (
    id INT UNIQUE NOT NULL,
    event_date INT,
    country VARCHAR(80) NOT NULL,
    counts INT, 
    population INT,
    events_per_capita FLOAT,
    gdp_per_capita FLOAT,
    western TINYINT(1),
    asian TINYINT(1),
    south_american TINYINT(1),
    public_trust_percentage FLOAT,
    PRIMARY KEY(id)
);

CREATE TABLE if not exists real_data_scaled (
    id INT UNIQUE NOT NULL,
    event_date INT,
    country VARCHAR(80) NOT NULL,
    western TINYINT(1),
    asian TINYINT(1),
    south_american TINYINT(1),
    counts INT, 
    population_scaled FLOAT,
    events_per_capita_scaled FLOAT,
    gdp_per_capita_scaled FLOAT,
    public_trust_percentage_scaled FLOAT,
    PRIMARY KEY(id)
);

INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('0', '2021', 'Australia', '681', '25685412', '2.65131040140606', '60697.2454358579', '1', '0', '0', '51.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('1', '2022', 'Australia', '794', '26005540', '3.05319558832464', '65099.8459118981', '1', '0', '0', '49.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('2', '2020', 'Austria', '354', '8916864', '3.97000559838078', '48789.4978498872', '1', '0', '0', '62.6');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('3', '2021', 'Austria', '562', '8955797', '6.27526506016159', '53517.8904509612', '1', '0', '0', '61');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('4', '2022', 'Austria', '294', '9041851', '3.25154661363033', '52084.6811953372', '1', '0', '0', '61');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('5', '2020', 'Belgium', '784', '11538604', '6.79458277621799', '45609.0034936111', '1', '0', '0', '29.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('6', '2021', 'Belgium', '833', '11586195', '7.18959071550237', '51850.3971840229', '1', '0', '0', '47.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('7', '2022', 'Belgium', '523', '11685814', '4.47551193267324', '49926.8254295305', '1', '0', '0', '57.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('8', '2018', 'Brazil', '6549', '210166592', '3.11609944172288', '9121.02099480377', '0', '0', '1', '16.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('9', '2019', 'Brazil', '3346', '211782878', '1.57991997823356', '8845.32414932264', '0', '0', '1', '34.1');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('10', '2020', 'Brazil', '2514', '213196304', '1.17919492638109', '6923.6999117682', '0', '0', '1', '36.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('11', '2021', 'Brazil', '4060', '214326223', '1.89430856531261', '7696.78483012849', '0', '0', '1', '32.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('12', '2022', 'Brazil', '3728', '215313498', '1.7314288396355', '8917.67491057495', '0', '0', '1', '39.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('13', '2021', 'Canada', '1691', '38226498', '4.42363305160729', '52515.1998350503', '1', '0', '0', '61');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('14', '2022', 'Canada', '1828', '38929902', '4.69561932110695', '55522.445687688', '1', '0', '0', '50.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('15', '2018', 'Chile', '1033', '18701450', '5.52363586780704', '15820.0333571155', '0', '0', '1', '33.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('16', '2019', 'Chile', '1590', '19039485', '8.35106621844026', '14632.6903076927', '0', '0', '1', '15.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('17', '2020', 'Chile', '1048', '19300315', '5.42996318971996', '13173.7847941723', '0', '0', '1', '17.1');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('18', '2021', 'Chile', '880', '19493184', '4.51439846871604', '16240.6077759729', '0', '0', '1', '23.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('19', '2022', 'Chile', '927', '19603733', '4.72869121406622', '15355.4797401048', '0', '0', '1', '28.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('20', '2018', 'Colombia', '406', '49276961', '0.823914445535714', '6782.03792033195', '0', '0', '1', '27.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('21', '2019', 'Colombia', '624', '50187406', '1.24333981317943', '6436.50921529527', '0', '0', '1', '32.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('22', '2020', 'Colombia', '686', '50930662', '1.3469292820109', '5304.28912886641', '0', '0', '1', '37.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('23', '2021', 'Colombia', '2283', '51516562', '4.43158454556808', '6182.70709867964', '0', '0', '1', '28.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('24', '2022', 'Colombia', '1364', '51874024', '2.62944706198231', '6624.16539269075', '0', '0', '1', '29.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('25', '2018', 'Costa Rica', '299', '5040734', '5.93167582340191', '12383.1499522763', '0', '0', '0', '48');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('26', '2019', 'Costa Rica', '335', '5084532', '6.58861031851112', '12669.3411549351', '0', '0', '0', '28.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('27', '2020', 'Costa Rica', '565', '5123105', '11.0284680872244', '12179.2566735195', '0', '0', '0', '29.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('28', '2021', 'Costa Rica', '192', '5153957', '3.72529301272789', '12604.0488374731', '0', '0', '0', '31.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('29', '2022', 'Costa Rica', '164', '5180829', '3.16551656115267', '13365.3563992692', '0', '0', '0', '60');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('30', '2020', 'Denmark', '561', '5831404', '9.62032471082436', '60836.5924121638', '1', '0', '0', '71.6');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('31', '2021', 'Denmark', '828', '5856733', '14.1375746512604', '69268.6517983134', '1', '0', '0', '65.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('32', '2022', 'Denmark', '371', '5903037', '6.28490046733571', '67790.0539923276', '1', '0', '0', '63.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('33', '2020', 'Estonia', '141', '1329522', '10.6053152937672', '23595.2436836441', '1', '0', '0', '46.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('34', '2021', 'Estonia', '113', '1330932', '8.49029101411643', '27943.701219882', '1', '0', '0', '51.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('35', '2022', 'Estonia', '74', '1348840', '5.48619554580232', '28247.095992497', '1', '0', '0', '50.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('36', '2020', 'Finland', '216', '5529543', '3.90629026666399', '49169.7193388499', '1', '0', '0', '80.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('37', '2021', 'Finland', '265', '5541017', '4.7825155562598', '53504.6936483441', '1', '0', '0', '71.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('38', '2022', 'Finland', '345', '5556106', '6.20938477415658', '50871.9304508821', '1', '0', '0', '77.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('39', '2020', 'France', '5165', '67571107', '7.64379959025979', '39179.7442596057', '1', '0', '0', '41');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('40', '2021', 'France', '8356', '67764304', '12.3309759073155', '43671.3084099631', '1', '0', '0', '43.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('41', '2022', 'France', '6421', '67971311', '9.44663256531862', '40886.2532680273', '1', '0', '0', '43.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('42', '2020', 'Germany', '4292', '83160871', '5.16108110507885', '46749.4762280016', '1', '0', '0', '65.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('43', '2021', 'Germany', '4215', '83196078', '5.06634459379203', '51426.7503654421', '1', '0', '0', '60.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('44', '2022', 'Germany', '4770', '83797985', '5.69226097739701', '48717.9911402128', '1', '0', '0', '60.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('45', '2018', 'Greece', '203', '10732882', '1.89138387993085', '19756.990456255', '1', '0', '0', '15.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('46', '2019', 'Greece', '497', '10721582', '4.6355099462001', '19143.8876174584', '1', '0', '0', '39.6');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('47', '2020', 'Greece', '660', '10698599', '6.16903203868095', '17617.2915057014', '1', '0', '0', '39.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('48', '2021', 'Greece', '558', '10569207', '5.27948785561679', '20310.6824798873', '1', '0', '0', '40.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('49', '2022', 'Greece', '434', '10426919', '4.16230336113669', '20867.2690861087', '1', '0', '0', '25.6');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('50', '2020', 'Hungary', '199', '9750149', '2.04099445044378', '16125.6094085407', '1', '0', '0', '42.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('51', '2021', 'Hungary', '128', '9709891', '1.31824342827329', '18753.0469453539', '1', '0', '0', '41.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('52', '2022', 'Hungary', '415', '9643048', '4.30361852393559', '18390.1849993244', '1', '0', '0', '44.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('53', '2020', 'Iceland', '29', '366463', '7.9134864911328', '58848.41812446', '1', '0', '0', '59.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('54', '2021', 'Iceland', '28', '372520', '7.51637495973371', '68710.2442005473', '1', '0', '0', '63.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('55', '2022', 'Iceland', '28', '382003', '7.32978536817774', '73466.7786674708', '1', '0', '0', '51.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('56', '2020', 'Ireland', '279', '4985382', '5.59636152254732', '85973.0884875501', '1', '0', '0', '58.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('57', '2021', 'Ireland', '218', '5033164', '4.33127154211546', '102001.798249145', '1', '0', '0', '62.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('58', '2022', 'Ireland', '279', '5127170', '5.44159838663434', '103983.29133582', '1', '0', '0', '62.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('59', '2016', 'Israel', '130', '8546000', '1.5211794991809', '37690.4739511859', '0', '0', '0', '43.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('60', '2017', 'Israel', '289', '8713300', '3.31676861808959', '41114.7817082553', '0', '0', '0', '38.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('61', '2018', 'Israel', '390', '8882800', '4.39050749763588', '42406.8454263606', '0', '0', '0', '42.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('62', '2019', 'Israel', '427', '9054000', '4.71614755908991', '44452.2325623093', '0', '0', '0', '49.6');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('63', '2020', 'Israel', '1221', '9215100', '13.2499918611844', '44846.7915954816', '0', '0', '0', '38.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('64', '2021', 'Israel', '994', '9371400', '10.6067396546941', '52129.5159612108', '0', '0', '0', '44');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('65', '2022', 'Israel', '737', '9557500', '7.7112215537536', '54930.9388075096', '0', '0', '0', '44');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('66', '2020', 'Italy', '5488', '59438851', '9.23301831658893', '31922.9191626183', '1', '0', '0', '37.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('67', '2021', 'Italy', '7367', '59133173', '12.4583201378353', '36449.2583375837', '1', '0', '0', '35.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('68', '2022', 'Italy', '4594', '58940425', '7.79431095042155', '34776.423234274', '1', '0', '0', '35.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('69', '2018', 'Japan', '1637', '126811000', '1.29089747734818', '39751.1330982711', '0', '1', '0', '38.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('70', '2019', 'Japan', '1289', '126633000', '1.01790212661786', '40415.9567649547', '0', '1', '0', '41.1');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('71', '2020', 'Japan', '1515', '126261000', '1.19989545465346', '40040.7655055923', '0', '1', '0', '42.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('72', '2021', 'Japan', '1419', '125681593', '1.1290436142069', '40058.5373276179', '0', '1', '0', '29.1');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('73', '2022', 'Japan', '1584', '125124989', '1.26593417722498', '34017.2718075024', '0', '1', '0', '43.1');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('74', '2020', 'Latvia', '68', '1900449', '3.57810180646784', '18096.2027073394', '1', '0', '0', '30.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('75', '2021', 'Latvia', '62', '1884490', '3.29001480506662', '20930.3982374189', '1', '0', '0', '29.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('76', '2022', 'Latvia', '47', '1879383', '2.50082074808594', '21779.5042572825', '1', '0', '0', '29.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('77', '2020', 'Lithuania', '59', '2794885', '2.11099920032488', '20381.8557827478', '1', '0', '0', '47.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('78', '2021', 'Lithuania', '148', '2800839', '5.28413093362382', '23849.6156993566', '1', '0', '0', '30.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('79', '2022', 'Lithuania', '76', '2831639', '2.68395794802939', '25064.808914729', '1', '0', '0', '30.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('80', '2020', 'Luxembourg', '35', '630419', '5.55186312595274', '116905.370396853', '1', '0', '0', '78');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('81', '2021', 'Luxembourg', '32', '640064', '4.999500049995', '133711.794435985', '1', '0', '0', '78');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('82', '2022', 'Luxembourg', '33', '653103', '5.05280177858623', '125006.021815486', '1', '0', '0', '78');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('83', '2018', 'Mexico', '4271', '124013861', '3.44396986398158', '10130.3206984553', '0', '0', '1', '29.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('84', '2019', 'Mexico', '4820', '125085311', '3.85337012113277', '10434.5783651735', '0', '0', '1', '49.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('85', '2020', 'Mexico', '5650', '125998302', '4.4841874138907', '8894.89065003643', '0', '0', '1', '45.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('86', '2021', 'Mexico', '6148', '126705138', '4.85221049204808', '10359.1498625832', '0', '0', '1', '48.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('87', '2022', 'Mexico', '6019', '127504125', '4.72063158740943', '11496.5228716049', '0', '0', '1', '52.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('88', '2020', 'Netherlands', '580', '17441500', '3.32540205830921', '52162.5701150406', '1', '0', '0', '78.1');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('89', '2021', 'Netherlands', '583', '17533044', '3.32514992832962', '58727.8705471475', '1', '0', '0', '58.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('90', '2022', 'Netherlands', '706', '17700982', '3.98847928323977', '57025.01245598', '1', '0', '0', '47.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('91', '2020', 'Norway', '294', '5379475', '5.46521733068747', '68340.0181033702', '1', '0', '0', '82.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('92', '2021', 'Norway', '307', '5408320', '5.67643926394888', '93072.8925119571', '1', '0', '0', '77.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('93', '2022', 'Norway', '482', '5457127', '8.83248639806257', '108729.18690323', '1', '0', '0', '63.6');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('94', '2020', 'Poland', '1827', '37899070', '4.82069876648688', '15816.8204021382', '1', '0', '0', '27.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('95', '2021', 'Poland', '1806', '37747124', '4.78447046720699', '18050.2794441161', '1', '0', '0', '25.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('96', '2022', 'Poland', '1152', '36821749', '3.12858577141461', '18688.0044867103', '1', '0', '0', '34.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('97', '2020', 'Portugal', '359', '10297081', '3.48642493926191', '22242.406417972', '1', '0', '0', '61.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('98', '2021', 'Portugal', '616', '10361831', '5.94489526030679', '24661.1664874576', '1', '0', '0', '57.6');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('99', '2022', 'Portugal', '331', '10409704', '3.17972537931914', '24515.2658507319', '1', '0', '0', '58.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('100', '2020', 'Slovenia', '132', '2102419', '6.27848207231765', '25558.4290544506', '1', '0', '0', '45.3');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('101', '2021', 'Slovenia', '138', '2108079', '6.54624423468001', '29331.0647010043', '1', '0', '0', '33.9');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('102', '2022', 'Slovenia', '64', '2111986', '3.03032311767218', '28439.3340989687', '1', '0', '0', '45.1');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('103', '2020', 'Spain', '3348', '47365655', '7.06841275603599', '26984.2962770279', '1', '0', '0', '38.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('104', '2021', 'Spain', '4405', '47415794', '9.29015340331536', '30488.8209528797', '1', '0', '0', '37.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('105', '2022', 'Spain', '3816', '47778340', '7.98688275900753', '29674.5442864413', '1', '0', '0', '37.2');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('106', '2020', 'Sweden', '904', '10353442', '8.73139580054633', '52837.9039778149', '1', '0', '0', '67.1');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('107', '2021', 'Sweden', '1244', '10415811', '11.9433810770952', '61417.6808766469', '1', '0', '0', '63.4');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('108', '2022', 'Sweden', '1473', '10486941', '14.0460406900354', '56424.2846986686', '1', '0', '0', '68.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('109', '2020', 'Switzerland', '165', '8638167', '1.910127461069', '85897.7843338323', '1', '0', '0', '84.6');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('110', '2021', 'Switzerland', '217', '8704546', '2.49295023542871', '93446.4344518943', '1', '0', '0', '83.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('111', '2022', 'Switzerland', '186', '8775760', '2.11947455263134', '93259.9057183024', '1', '0', '0', '83.8');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('112', '2020', 'United Kingdom', '2196', '67081234', '3.27364281939119', '40217.0090116986', '1', '0', '0', '34.7');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('113', '2021', 'United Kingdom', '1585', '67026292', '2.36474367401974', '46869.759058411', '1', '0', '0', '39.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('114', '2022', 'United Kingdom', '1745', '66971395', '2.60559004333119', '46125.2557513568', '1', '0', '0', '39.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('115', '2020', 'United States', '21585', '331511512', '6.51108610671716', '63528.6343027508', '1', '0', '0', '46.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('116', '2021', 'United States', '13147', '332031554', '3.95956343354042', '70219.472454115', '1', '0', '0', '40.5');
INSERT INTO real_data (id, event_date, country, counts, population, events_per_capita, gdp_per_capita, western, asian, south_american, public_trust_percentage) VALUES ('117', '2022', 'United States', '12183', '333287557', '3.65540199270026', '76329.5822652029', '1', '0', '0', '31');


INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('0', '2021', 'Australia', '1', '0', '0', '681', '-0.283', '-0.834', '0.72', '0.288');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('1', '2022', 'Australia', '1', '0', '0', '794', '-0.278', '-0.699', '0.877', '0.168');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('2', '2020', 'Austria', '1', '0', '0', '354', '-0.524', '-0.391', '0.295', '0.93');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('3', '2021', 'Austria', '1', '0', '0', '562', '-0.523', '0.384', '0.464', '0.834');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('4', '2022', 'Austria', '1', '0', '0', '294', '-0.522', '-0.632', '0.412', '0.834');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('5', '2020', 'Belgium', '1', '0', '0', '784', '-0.486', '0.559', '0.181', '-1.057');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('6', '2021', 'Belgium', '1', '0', '0', '833', '-0.485', '0.691', '0.404', '0.012');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('7', '2022', 'Belgium', '1', '0', '0', '523', '-0.484', '-0.221', '0.335', '0.606');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('8', '2018', 'Brazil', '0', '0', '1', '6549', '2.368', '-0.678', '-1.122', '-1.819');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('9', '2019', 'Brazil', '0', '0', '1', '3346', '2.391', '-1.194', '-1.132', '-0.781');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('10', '2020', 'Brazil', '0', '0', '1', '2514', '2.411', '-1.329', '-1.201', '-0.655');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('11', '2021', 'Brazil', '0', '0', '1', '4060', '2.427', '-1.088', '-1.173', '-0.865');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('12', '2022', 'Brazil', '0', '0', '1', '3728', '2.441', '-1.143', '-1.13', '-0.475');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('13', '2021', 'Canada', '1', '0', '0', '1691', '-0.103', '-0.238', '0.428', '0.834');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('14', '2022', 'Canada', '1', '0', '0', '1828', '-0.093', '-0.147', '0.535', '0.216');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('15', '2018', 'Chile', '0', '0', '1', '1033', '-0.383', '0.131', '-0.883', '-0.817');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('16', '2019', 'Chile', '0', '0', '1', '1590', '-0.378', '1.082', '-0.926', '-1.909');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('17', '2020', 'Chile', '0', '0', '1', '1048', '-0.375', '0.1', '-0.978', '-1.801');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('18', '2021', 'Chile', '0', '0', '1', '880', '-0.372', '-0.208', '-0.868', '-1.435');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('19', '2022', 'Chile', '0', '0', '1', '927', '-0.37', '-0.136', '-0.9', '-1.105');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('20', '2018', 'Colombia', '0', '0', '1', '406', '0.056', '-1.448', '-1.206', '-1.177');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('21', '2019', 'Colombia', '0', '0', '1', '624', '0.069', '-1.307', '-1.218', '-0.859');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('22', '2020', 'Colombia', '0', '0', '1', '686', '0.08', '-1.272', '-1.259', '-0.583');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('23', '2021', 'Colombia', '0', '0', '1', '2283', '0.088', '-0.236', '-1.227', '-1.093');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('24', '2022', 'Colombia', '0', '0', '1', '1364', '0.093', '-0.841', '-1.212', '-1.045');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('25', '2018', 'Costa Rica', '0', '0', '0', '299', '-0.58', '0.269', '-1.006', '0.054');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('26', '2019', 'Costa Rica', '0', '0', '0', '335', '-0.579', '0.489', '-0.996', '-1.129');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('27', '2020', 'Costa Rica', '0', '0', '0', '565', '-0.578', '1.981', '-1.013', '-1.039');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('28', '2021', 'Costa Rica', '0', '0', '0', '192', '-0.578', '-0.473', '-0.998', '-0.937');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('29', '2022', 'Costa Rica', '0', '0', '0', '164', '-0.577', '-0.661', '-0.971', '0.774');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('30', '2020', 'Denmark', '1', '0', '0', '561', '-0.568', '1.508', '0.725', '1.47');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('31', '2021', 'Denmark', '1', '0', '0', '828', '-0.568', '3.026', '1.026', '1.086');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('32', '2022', 'Denmark', '1', '0', '0', '371', '-0.567', '0.387', '0.973', '0.984');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('33', '2020', 'Estonia', '1', '0', '0', '141', '-0.633', '1.839', '-0.605', '-0.036');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('34', '2021', 'Estonia', '1', '0', '0', '113', '-0.633', '1.128', '-0.45', '0.288');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('35', '2022', 'Estonia', '1', '0', '0', '74', '-0.633', '0.119', '-0.439', '0.222');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('36', '2020', 'Finland', '1', '0', '0', '216', '-0.572', '-0.412', '0.308', '2.028');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('37', '2021', 'Finland', '1', '0', '0', '265', '-0.572', '-0.118', '0.463', '1.458');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('38', '2022', 'Finland', '1', '0', '0', '345', '-0.572', '0.362', '0.369', '1.824');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('39', '2020', 'France', '1', '0', '0', '5165', '0.319', '0.844', '-0.049', '-0.367');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('40', '2021', 'France', '1', '0', '0', '8356', '0.322', '2.419', '0.112', '-0.223');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('41', '2022', 'France', '1', '0', '0', '6421', '0.325', '1.45', '0.012', '-0.223');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('42', '2020', 'Germany', '1', '0', '0', '4292', '0.543', '0.01', '0.222', '1.098');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('43', '2021', 'Germany', '1', '0', '0', '4215', '0.543', '-0.022', '0.389', '0.804');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('44', '2022', 'Germany', '1', '0', '0', '4770', '0.552', '0.188', '0.292', '0.822');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('45', '2018', 'Greece', '1', '0', '0', '203', '-0.498', '-1.089', '-0.742', '-1.885');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('46', '2019', 'Greece', '1', '0', '0', '497', '-0.498', '-0.167', '-0.764', '-0.451');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('47', '2020', 'Greece', '1', '0', '0', '660', '-0.498', '0.348', '-0.819', '-0.445');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('48', '2021', 'Greece', '1', '0', '0', '558', '-0.5', '0.049', '-0.723', '-0.415');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('49', '2022', 'Greece', '1', '0', '0', '434', '-0.502', '-0.326', '-0.703', '-1.291');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('50', '2020', 'Hungary', '1', '0', '0', '199', '-0.512', '-1.039', '-0.872', '-0.253');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('51', '2021', 'Hungary', '1', '0', '0', '128', '-0.512', '-1.282', '-0.778', '-0.325');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('52', '2022', 'Hungary', '1', '0', '0', '415', '-0.513', '-0.279', '-0.791', '-0.175');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('53', '2020', 'Iceland', '1', '0', '0', '29', '-0.647', '0.935', '0.654', '0.726');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('54', '2021', 'Iceland', '1', '0', '0', '28', '-0.647', '0.801', '1.006', '0.978');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('55', '2022', 'Iceland', '1', '0', '0', '28', '-0.646', '0.738', '1.176', '0.264');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('56', '2020', 'Ireland', '1', '0', '0', '279', '-0.58', '0.156', '1.623', '0.702');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('57', '2021', 'Ireland', '1', '0', '0', '218', '-0.58', '-0.269', '2.196', '0.912');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('58', '2022', 'Ireland', '1', '0', '0', '279', '-0.578', '0.104', '2.266', '0.912');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('59', '2016', 'Israel', '0', '0', '0', '130', '-0.529', '-1.214', '-0.102', '-0.199');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('60', '2017', 'Israel', '0', '0', '0', '289', '-0.527', '-0.61', '0.021', '-0.493');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('61', '2018', 'Israel', '0', '0', '0', '390', '-0.524', '-0.249', '0.067', '-0.295');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('62', '2019', 'Israel', '0', '0', '0', '427', '-0.522', '-0.14', '0.14', '0.15');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('63', '2020', 'Israel', '0', '0', '0', '1221', '-0.52', '2.728', '0.154', '-0.493');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('64', '2021', 'Israel', '0', '0', '0', '994', '-0.517', '1.84', '0.414', '-0.187');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('65', '2022', 'Israel', '0', '0', '0', '737', '-0.515', '0.867', '0.514', '-0.187');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('66', '2020', 'Italy', '1', '0', '0', '5488', '0.202', '1.378', '-0.308', '-0.577');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('67', '2021', 'Italy', '1', '0', '0', '7367', '0.198', '2.462', '-0.146', '-0.703');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('68', '2022', 'Italy', '1', '0', '0', '4594', '0.195', '0.895', '-0.206', '-0.703');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('69', '2018', 'Japan', '0', '1', '0', '1637', '1.17', '-1.291', '-0.028', '-0.517');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('70', '2019', 'Japan', '0', '1', '0', '1289', '1.167', '-1.383', '-0.004', '-0.361');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('71', '2020', 'Japan', '0', '1', '0', '1515', '1.162', '-1.322', '-0.018', '-0.289');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('72', '2021', 'Japan', '0', '1', '0', '1419', '1.154', '-1.345', '-0.017', '-1.081');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('73', '2022', 'Japan', '0', '1', '0', '1584', '1.146', '-1.299', '-0.233', '-0.241');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('74', '2020', 'Latvia', '1', '0', '0', '68', '-0.625', '-0.522', '-0.802', '-0.985');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('75', '2021', 'Latvia', '1', '0', '0', '62', '-0.625', '-0.619', '-0.701', '-1.057');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('76', '2022', 'Latvia', '1', '0', '0', '47', '-0.625', '-0.884', '-0.67', '-1.057');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('77', '2020', 'Lithuania', '1', '0', '0', '59', '-0.612', '-1.015', '-0.72', '0.018');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('78', '2021', 'Lithuania', '1', '0', '0', '148', '-0.612', '0.051', '-0.596', '-1.003');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('79', '2022', 'Lithuania', '1', '0', '0', '76', '-0.611', '-0.823', '-0.553', '-1.003');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('80', '2020', 'Luxembourg', '1', '0', '0', '35', '-0.643', '0.141', '2.728', '1.854');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('81', '2021', 'Luxembourg', '1', '0', '0', '32', '-0.643', '-0.045', '3.328', '1.854');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('82', '2022', 'Luxembourg', '1', '0', '0', '33', '-0.643', '-0.027', '3.017', '1.854');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('83', '2018', 'Mexico', '0', '0', '1', '4271', '1.13', '-0.567', '-1.086', '-1.057');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('84', '2019', 'Mexico', '0', '0', '1', '4820', '1.145', '-0.43', '-1.076', '0.144');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('85', '2020', 'Mexico', '0', '0', '1', '5650', '1.158', '-0.218', '-1.131', '-0.072');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('86', '2021', 'Mexico', '0', '0', '1', '6148', '1.168', '-0.094', '-1.078', '0.072');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('87', '2022', 'Mexico', '0', '0', '1', '6019', '1.18', '-0.138', '-1.038', '0.348');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('88', '2020', 'Netherlands', '1', '0', '0', '580', '-0.401', '-0.607', '0.415', '1.86');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('89', '2021', 'Netherlands', '1', '0', '0', '583', '-0.4', '-0.607', '0.65', '0.684');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('90', '2022', 'Netherlands', '1', '0', '0', '706', '-0.398', '-0.384', '0.589', '0.006');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('91', '2020', 'Norway', '1', '0', '0', '294', '-0.575', '0.112', '0.993', '2.148');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('92', '2021', 'Norway', '1', '0', '0', '307', '-0.574', '0.183', '1.877', '1.818');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('93', '2022', 'Norway', '1', '0', '0', '482', '-0.574', '1.243', '2.436', '0.99');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('94', '2020', 'Poland', '1', '0', '0', '1827', '-0.107', '-0.105', '-0.883', '-1.189');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('95', '2021', 'Poland', '1', '0', '0', '1806', '-0.11', '-0.117', '-0.803', '-1.273');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('96', '2022', 'Poland', '1', '0', '0', '1152', '-0.123', '-0.673', '-0.781', '-0.775');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('97', '2020', 'Portugal', '1', '0', '0', '359', '-0.504', '-0.553', '-0.654', '0.864');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('98', '2021', 'Portugal', '1', '0', '0', '616', '-0.503', '0.273', '-0.567', '0.63');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('99', '2022', 'Portugal', '1', '0', '0', '331', '-0.502', '-0.656', '-0.573', '0.708');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('100', '2020', 'Slovenia', '1', '0', '0', '132', '-0.622', '0.385', '-0.535', '-0.108');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('101', '2021', 'Slovenia', '1', '0', '0', '138', '-0.622', '0.475', '-0.4', '-0.793');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('102', '2022', 'Slovenia', '1', '0', '0', '64', '-0.622', '-0.706', '-0.432', '-0.12');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('103', '2020', 'Spain', '1', '0', '0', '3348', '0.029', '0.651', '-0.484', '-0.535');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('104', '2021', 'Spain', '1', '0', '0', '4405', '0.029', '1.397', '-0.359', '-0.595');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('105', '2022', 'Spain', '1', '0', '0', '3816', '0.035', '0.959', '-0.388', '-0.595');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('106', '2020', 'Sweden', '1', '0', '0', '904', '-0.503', '1.21', '0.439', '1.2');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('107', '2021', 'Sweden', '1', '0', '0', '1244', '-0.502', '2.289', '0.746', '0.978');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('108', '2022', 'Sweden', '1', '0', '0', '1473', '-0.501', '2.996', '0.567', '1.302');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('109', '2020', 'Switzerland', '1', '0', '0', '165', '-0.528', '-1.083', '1.62', '2.25');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('110', '2021', 'Switzerland', '1', '0', '0', '217', '-0.527', '-0.887', '1.89', '2.202');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('111', '2022', 'Switzerland', '1', '0', '0', '186', '-0.526', '-1.013', '1.883', '2.202');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('112', '2020', 'United Kingdom', '1', '0', '0', '2196', '0.312', '-0.625', '-0.012', '-0.745');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('113', '2021', 'United Kingdom', '1', '0', '0', '1585', '0.311', '-0.93', '0.226', '-0.457');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('114', '2022', 'United Kingdom', '1', '0', '0', '1745', '0.31', '-0.849', '0.2', '-0.457');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('115', '2020', 'United States', '1', '0', '0', '21585', '4.111', '0.463', '0.821', '-0.036');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('116', '2021', 'United States', '1', '0', '0', '13147', '4.118', '-0.394', '1.06', '-0.397');
INSERT INTO real_data_scaled (id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled) VALUES ('117', '2022', 'United States', '1', '0', '0', '12183', '4.136', '-0.496', '1.279', '-0.967');


INSERT INTO cause (cause_id, cause_name) VALUES ('1', 'Racial Inequality');
INSERT INTO cause (cause_id, cause_name) VALUES ('2', 'Climate Change');
INSERT INTO cause (cause_id, cause_name) VALUES ('3', 'Political Corruption');
INSERT INTO cause (cause_id, cause_name) VALUES ('4', 'Gender Equality');
INSERT INTO cause (cause_id, cause_name) VALUES ('5', 'Animal Rights');
INSERT INTO cause (cause_id, cause_name) VALUES ('6', 'Black Lives Matter');
INSERT INTO cause (cause_id, cause_name) VALUES ('7', 'Israeli-Palestine');

INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Albania', '52.92169137725642', '2777689', '6810.11404104233', '11.629', '63.799', '131.750834819418', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Argentina', '53.401299409990266', '46234830', '13650.6046294524', '6.805', '92.347', NULL, 'South America');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Australia', '30.531955883246415', '26005540', '65099.8459118981', '3.7', '86.488', '132.466181061394', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Austria', '32.51546613630329', '9041851', '52084.6811953372', '4.99', '59.256', '133.513565675464', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Belgium', '44.7551193267324', '11685814', '49926.8254295305', '5.56', '98.153', '132.456219048303', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Brazil', '17.314288396354975', '215313498', '8917.67491057495', '9.23', '87.555', '204.482120615775', 'South America');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Bulgaria', '93.5794157458117', '6465097', '13974.4492487792', '4.27', '76.363', '138.584408106261', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Canada', '46.956193211069476', '38929902', '55522.445687688', '5.28', '81.752', '129.858328563251', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Chile', '47.28691214066219', '19603733', '15355.4797401048', '8.25', '87.912', '158.625026875941', 'South America');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Colombia', '26.29447061982313', '51874024', '6624.16539269075', '10.55', '82.05', '164.780806314133', 'South America');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Costa Rica', '31.65516561152665', '5180829', '13365.3563992692', '11.32', '82.042', '142.944768574546', 'South America');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Croatia', '28.789293495175848', '3855600', '18570.4039968345', '6.96', '58.219', '124.955261274159', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Denmark', '62.84900467335713', '5903037', '67790.0539923276', '4.43', '88.367', '121.55164717436', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Estonia', '54.86195545802319', '1348840', '28247.095992497', '5.57', '69.609', '151.94333206325', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Finland', '62.09384774156577', '5556106', '50871.9304508821', '6.72', '85.681', '123.331790076698', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'France', '94.46632565318623', '67971311', '40886.2532680273', '7.31', '81.509', '118.258283622798', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Germany', '56.9226097739701', '83797985', '48717.9911402128', '3.14', '77.648', '124.489744387368', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Greece', '41.623033611366886', '10426919', '20867.2690861087', '12.43', '80.357', '111.738622172264', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Hungary', '43.03618523935586', '9643048', '18390.1849993244', '3.61', '72.552', '151.411885949845', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Iceland', '73.29785368177737', '382003', '73466.7786674708', '3.79', '93.992', '150.087495958498', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'India', '10.321250979537135', '1417173173', '2410.88802070689', '4.822', '35.872', '205.266241146235', 'Asia');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Indonesia', '11.13969177478299', '275501339', '4787.99930771921', '3.46', '57.934', '163.071752418121', 'Asia');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Ireland', '54.415983866343424', '5127170', '103983.29133582', '4.48', '64.183', '117.221883969731', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Israel', '77.11221553753597', '9557500', '54930.9388075096', '3.695', '92.763', '113.939796790428', 'Asia');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Italy', '77.94310950421549', '58940425', '34776.423234274', '8.07', '71.657', '121.771084752039', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Jamaica', '38.90531754343337', '2827377', '6047.2164567796', '5.499', '57.008', '199.742721733243', NULL);
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Japan', '12.659341772249826', '125124989', '34017.2718075024', '2.6', '91.955', '107.839690631042', 'Asia');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Kosovo', '74.91550722622496', '1761985', '5340.26879794836', NULL , NULL, '136.426245250384', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Latvia', '25.008207480859408', '1879383', '21779.5042572825', '6.81', '68.54', '141.886081804437', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Lithuania', '26.83957948029392', '2831639', '25064.808914729', '5.96', '68.465', '150.12636507601', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Luxembourg', '50.52801778586226', '653103', '125006.021815486', '4.58', '91.881', '126.501046501047', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Malta', '152.5099178517566', '531113', '34127.5105566356', '2.92', '94.875', '123.018580023951', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Mexico', '47.20631587409427', '127504125', '11496.5228716049', '3.26', '81.3', '166.890369321443', 'South America');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Mongolia', '37.66516025642912', '3398366', '5045.50470031666', '6.21', '68.93', '251.172516573854', 'Asia');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Netherlands', '39.88479283239766', '17700982', '57025.01245598', '3.52', '92.886', '132.577542831667', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Norway', '88.32486398062571', '5457127', '108729.18690323', '3.23', '83.664', '133.32730069677', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Philippines', '2.327815047288957', '115559009', '3498.5098055874', '2.375', '47.977', '145.965868357034', 'Asia');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Poland', '31.28585771414606', '36821749', '18688.0044867103', '2.89', '60.134', '141.807246589409', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Portugal', '31.797253793191434', '10409704', '24515.2658507319', '6.01', '67.381', '120.783990313085', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Romania', '10.815346388506457', '19047009', '15786.8017421977', '5.61', '54.489', '151.866303747835', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Serbia', '57.01896735949213', '6664449', '9537.68286673128', '8.684', '56.873', '170.482256596906', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Singapore', '0.7095945341352224', '5637022', '82807.6290622897', '3.59', '100.0', '123.980978131334', 'Asia');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Slovenia', '30.303231176721816', '2111986', '28439.3340989687', '4.01', '55.751', '123.110404802896', 'Eastern Europe');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Spain', '79.86882759007533', '47778340', '29674.5442864413', '12.92', '81.304', '123.591728295232', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Sweden', '140.4604069003535', '10486941', '56424.2846986686', '7.39', '88.492', '122.957183435409', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Switzerland', '21.19474552631339', '8775760', '93259.9057183024', '4.3', '74.092', '102.21728177187', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Thailand', '4.672439011769386', '71697030', '6909.9562847948', '0.94', '52.889', '120.59868874216', 'Asia');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'United Kingdom', '26.055900433311862', '66971395', '46125.2557513568', '3.73', '84.398', '133.660070279268', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'United States', '36.55401992700256', '333287557', '76329.5822652029', '3.65', '83.084', '134.21120616846', 'Western');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate, region) VALUES ('2022', 'Uruguay', '31.5531697204097', '3422794', '20795.0423535553', '7.87', '95.688', '261.824349714601', 'South America');

INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('1', 'Sally', 'Clark', 'csimacek0@admin.ch', 'Sweden', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('2', 'Filippa', 'Irvin', 'firvin1@prnewswire.com', 'Israel', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('3', 'Sydney', 'Stone', 'ggreenacre2@networkadvertising.org', 'Uruguay', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('4', 'Julieta', 'Ballantine', 'jballantine3@moonfruit.com', 'Philippines', 'Politician', 'Democratic');
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('5', 'Fay', 'Sallenger', 'fsallenger4@odnoklassniki.ru', 'Finland', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('6', 'Bartel', 'Valder', 'bvalder5@1und1.de', 'Slovenia', 'Activist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('7', 'Lyn', 'Nuschke', 'lnuschke6@merriam-webster.com', 'Jamaica', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('8', 'Nariko', 'MacGlory', 'nmacglory7@hao123.com', 'Jamaica', 'Politician', 'Democratic');
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('9', 'Sheff', 'Baskett', 'sbaskett8@about.me', 'Costa Rica', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('10', 'Ronald', 'Davion', 'rdavion9@ibm.com', 'Poland', 'Activist', NULL);

INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('1', 'Panggungsari', '2024-01-19', 'Nullam varius. Nulla facilisi.', '0', NULL, 'Malta', '5', '111.813634', '-8.1265731');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('2', 'Chotcza', '2020-03-27', 'Morbi porttitor lorem id ligula.', '1', NULL, 'Germany', '4', '21.4274273', '51.1227795');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('3', 'Changjiang', '2021-12-02', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.', '1', '2', 'Ireland', '6', '112.8915932', '30.5211502');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('4', 'Burunday', '2022-10-20', 'Morbi non lectus.', '0', '3', 'Denmark', '1', '76.840271', '43.32756');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('5', 'Usa River', '2019-02-19', 'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', '1', NULL, 'Italy', '4', '36.8398354', '-3.380978');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('6', 'Pesucen', '2022-06-30', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '0', NULL, 'Brazil', '6', '114.3014572', '-8.1574988');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('7', 'Leninogorsk', '2022-05-27', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '0', NULL, 'Brazil', '2', '52.4387134', '54.6001467');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('8', 'Grindavík', '2021-01-30', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '1', '6', 'Albania', '6', '-22.410284', '63.839604');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('9', 'Puerto Galera', '2019-07-29', 'Proin at turpis a pede posuere nonummy.', '0', NULL, 'Sweden', '7', '120.9617948', '13.5218669');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('10', 'Zarechnyy', '2019-01-15', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.', '0', '4', 'Austria', '5', '73.328393', '54.982808');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('11', 'Hengliang', '2021-08-08', 'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '0', NULL, 'Iceland', '1', '118.930364', '32.31876');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('12', 'Magisterial', '2020-01-15', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '1', NULL, 'Mexico', '7', '-99.110685', '19.2949759');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('13', 'Dawan', '2021-04-29', 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '1', '5', 'Ireland', '1', '115.4378152', '-8.5435854');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('14', 'Borås', '2021-11-11', 'Vivamus tortor.', '0', NULL, 'Romania', '3', '12.933356', '57.7197857');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('15', 'Sofádes', '2020-02-24', 'In congue. Etiam justo.', '0', '4', 'Hungary', '4', '22.097651', '39.335659');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('16', 'Lichinga', '2022-06-18', 'Quisque ut erat. Curabitur gravida nisi at nibh.', '1', '4', 'Brazil', '2', '35.2478112', '-13.3023564');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('17', 'Värnamo', '2021-06-22', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '0', NULL, 'Malta', '7', '14.0338655', '57.2033415');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('18', 'Kálymnos', '2021-03-08', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '1', NULL, 'Netherlands', '3', '26.9807653', '36.9522824');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('19', 'Szolnok', '2022-06-04', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '1', NULL, 'Australia', '7', '20.1974097', '47.1594836');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('20', 'Kasakh', '2021-07-08', 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', '0', '10', 'Spain', '5', '44.4514419', '40.2355256');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('21', 'Saint-Étienne', '2023-07-08', 'Praesent blandit lacinia erat.', '1', NULL, 'Belgium', '6', '4.3637137', '45.4815563');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('22', 'Ōnojō', '2023-12-04', 'Aliquam erat volutpat.', '0', NULL, 'India', '1', '137.0770574', '34.8383901');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('23', 'Yulin', '2024-02-25', 'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', '1', '1', 'Mexico', '7', '110.18122', '22.654032');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('24', 'Galyugayevskaya', '2021-04-14', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '0', NULL, 'Brazil', '3', '44.93444', '43.69694');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('25', 'Toupi', '2019-08-12', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', '1', '8', 'Portugal', '6', '116.19359', '26.751281');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('26', 'Gon’ba', '2022-10-02', 'Mauris sit amet eros.', '1', '4', 'Serbia', '2', '83.5779817', '53.4154689');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('27', 'Zhaowanzhuang', '2022-06-02', 'Morbi a ipsum. Integer a nibh. In quis justo.', '1', '5', 'Canada', '5', '116.087054', '35.242057');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('28', 'Ugac Sur', '2023-02-25', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '1', '10', 'Albania', '3', '121.7177272', '17.6102139');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('29', 'Rojas', '2020-02-10', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.', '0', NULL, 'Denmark', '2', '-58.4464356', '-34.6089515');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('30', 'Al Fūlah', '2019-11-21', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', '0', '4', 'Singapore', '1', '28.3578828', '11.7315405');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('31', 'Paris La Défense', '2022-08-09', 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '1', NULL, 'Denmark', '4', '2.233089', '48.892701');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('32', 'Nginokrajan', '2021-08-21', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '1', '2', 'Belgium', '7', '112.0647', '-6.9936');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('33', 'Jurak Lao’', '2019-03-18', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', '1', '8', 'Estonia', '1', '109.325464', '-0.0142486');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('34', 'Sanhu', '2019-09-01', 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '0', NULL, 'Colombia', '2', '113.6710978', '23.2008019');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('35', 'Mirimire', '2023-01-09', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', '0', NULL, 'Thailand', '3', '-68.7259306', '11.1626327');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('36', 'Morón', '2020-03-23', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '0', NULL, 'Estonia', '5', '-78.6228504', '22.0897108');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('37', 'Kalej', '2020-11-15', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', '1', NULL, 'Greece', '6', '-80.6150117', '41.0213628');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('38', 'Pridonskoy', '2019-01-01', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.', '0', NULL, 'Ireland', '7', '39.0891762', '51.6521236');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('39', 'Paris 19', '2023-04-19', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '1', '1', 'Albania', '1', '5.8978018', '43.4945737');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('40', 'Américo Brasiliense', '2020-12-28', 'Duis mattis egestas metus.', '0', '3', 'Mexico', '5', '-48.0605108', '-21.7300823');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('41', 'Suchy Dąb', '2020-03-17', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', '1', NULL, 'United Kingdom', '7', '18.7647749', '54.2315533');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('42', 'Sayama', '2023-03-11', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', '0', NULL, 'Japan', '3', '131.3494901', '34.0313411');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('43', 'Khao Kho', '2021-06-10', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '1', '5', 'United Kingdom', '6', '101.0118776', '16.6482598');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('44', 'General Pinedo', '2023-10-20', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '1', NULL, 'Serbia', '4', '-58.3762722', '-34.679347');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('45', 'Baima', '2023-03-11', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '1', '7', 'Italy', '1', '104.990101', '29.528923');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('46', 'Paipu', '2023-07-17', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '1', NULL, 'Kosovo', '4', '116.342934', '22.980665');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('47', 'São João de Caparica', '2019-02-16', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', '0', NULL, 'Philippines', '2', '-9.2406619', '38.661678');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('48', 'Krajan Gajihan', '2020-02-02', 'Aliquam non mauris. Morbi non lectus.', '1', NULL, 'Singapore', '3', '110.6013327', '-7.6185371');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('49', 'Los Palacios', '2023-10-21', 'Pellentesque at nulla.', '1', NULL, 'Serbia', '7', '-83.2425711', '22.588115');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('50', 'Huichang', '2023-01-31', 'Nunc purus. Phasellus in felis. Donec semper sapien a libero.', '1', '1', 'Latvia', '5', '115.786056', '25.600272');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('51', 'Riachos', '2019-01-19', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', '1', '6', 'France', '3', '-8.5116903', '39.4381452');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('52', 'Vellinge', '2024-03-28', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '1', NULL, 'Ireland', '3', '12.9658307', '55.496478');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('53', 'San Juan', '2021-06-26', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '0', NULL, 'Finland', '7', '121.0317737', '14.565668');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('54', 'Carrascal', '2019-01-24', 'Morbi a ipsum. Integer a nibh.', '1', NULL, 'Luxembourg', '2', '-7.9808794', '39.7213971');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('55', 'Sakura', '2021-12-28', 'Donec ut mauris eget massa tempor convallis.', '0', NULL, 'Jamaica', '4', '140.8706157', '38.1086472');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('56', 'Kapsan-ŭp', '2019-01-07', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '0', '7', 'United States', '6', '128.29333', '41.09028');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('57', 'Ikar', '2023-02-14', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '1', NULL, 'Mongolia', '1', '115.2402986', '-8.615202');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('58', 'Chakaray', '2021-11-28', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '0', NULL, 'Israel', '6', '69.4377', '34.34099');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('59', 'Matnah', '2022-03-08', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.', '1', NULL, 'Italy', '7', '44.0270562', '15.2525945');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('60', 'Zabłocie', '2020-03-21', 'Nullam molestie nibh in lectus.', '0', NULL, 'Singapore', '1', '16.611189', '51.0610829');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('61', 'Ji’ergele Teguoleng', '2023-06-05', 'Nullam molestie nibh in lectus.', '0', NULL, 'Latvia', '3', '84.17916', '44.35542');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('62', 'Yengimahalla', '2023-03-09', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', '1', '6', 'Norway', '6', '82.63142', '41.356361');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('63', 'Vynohradiv', '2022-05-16', 'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', '0', '4', 'Switzerland', '1', '23.0302123', '48.1463491');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('64', 'Calçada', '2021-08-11', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '0', NULL, 'Italy', '6', '-8.6450785', '42.0328151');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('65', 'Stockholm', '2023-11-25', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '1', NULL, 'Canada', '1', '18.0667759', '59.3405742');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('66', 'Vancouver', '2021-07-19', 'Nulla ut erat id mauris vulputate elementum.', '0', '2', 'Hungary', '3', '-122.52', '45.63');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('67', 'Ruoqiang', '2023-11-07', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '1', NULL, 'United Kingdom', '1', '88.166695', '39.024258');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('68', 'Nuštar', '2020-04-02', 'Nulla tellus. In sagittis dui vel nisl.', '0', '1', 'Hungary', '4', '18.8818902', '45.3098715');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('69', 'Yuzhou', '2019-05-10', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', '1', NULL, 'Philippines', '5', '120.585289', '31.298974');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('70', 'Mirów', '2020-10-01', 'Phasellus in felis. Donec semper sapien a libero.', '1', NULL, 'Ireland', '7', '19.46436', '50.614436');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('71', 'Welkom', '2024-05-17', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '1', NULL, 'Kosovo', '5', '26.77027', '-27.9699645');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('72', 'Zawichost', '2021-02-04', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', '1', NULL, 'Portugal', '3', '21.8528832', '50.8075698');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('73', 'Bordeaux', '2023-01-15', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '1', NULL, 'Spain', '5', '-0.5494198', '44.8445542');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('74', 'Yangjiapo', '2023-08-14', 'Aliquam erat volutpat. In congue. Etiam justo.', '0', NULL, 'Norway', '1', '111.982232', '21.857958');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('75', 'Dayr Abū Ḑa‘īf', '2021-05-02', 'Nam tristique tortor eu pede.', '0', NULL, 'Portugal', '6', '35.364922', '32.456061');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('76', 'Sambava', '2022-03-13', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '1', '5', 'Albania', '7', '50.1678121', '-14.2713338');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('77', 'Kuznetsovs’k', '2019-01-01', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', '0', NULL, 'Germany', '2', '25.8490867', '51.3436553');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('78', 'Madīnat ash Shamāl', '2019-01-30', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '0', NULL, 'Japan', '5', '51.3385684', '25.9210961');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('79', 'Rio Piracicaba', '2024-01-14', 'In sagittis dui vel nisl.', '1', NULL, 'Mongolia', '4', '-43.1359542', '-19.9661142');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('80', 'Zeerust', '2021-07-22', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.', '0', '1', 'Albania', '7', '26.07191', '-25.5468699');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('81', 'Nishio', '2024-02-07', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '1', '3', 'Iceland', '1', '139.7874841', '37.4056028');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('82', 'Xushuguan', '2021-05-08', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '1', '4', 'Slovenia', '2', '121.4228893', '31.1429853');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('83', 'Golcowa', '2022-10-23', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', '0', NULL, 'Norway', '1', '22.0252771', '49.7708764');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('84', 'Welisara', '2019-04-15', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '1', NULL, 'Austria', '5', '79.9020405', '7.0241972');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('85', 'Itumbiara', '2023-01-08', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '0', NULL, 'Austria', '7', '-49.2162908', '-18.4097245');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('86', 'Salt Lake City', '2023-01-28', 'Morbi ut odio.', '1', '4', 'Philippines', '4', '-111.94', '40.7');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('87', 'Paris 13', '2022-02-16', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '0', NULL, 'Uruguay', '3', '2.3757659', '48.8335842');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('88', 'Wadung', '2022-04-11', 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', '1', NULL, 'Belgium', '5', '111.9075351', '-7.0448624');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('89', 'Micheng', '2019-11-19', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', '0', '7', 'Kosovo', '6', '115.008163', '31.172739');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('90', 'Tongyuanpu', '2020-12-10', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', '1', NULL, 'India', '7', '123.9253791', '40.796787');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('91', 'Haninge', '2022-06-15', 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', '0', '10', 'Japan', '5', '18.236243', '59.1743158');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('92', 'Matiguás', '2022-11-17', 'Sed accumsan felis.', '0', '3', 'Albania', '1', '-85.4607639', '12.8383201');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('93', 'Paraipaba', '2021-05-10', 'Donec vitae nisi.', '0', '4', 'Iceland', '7', '-39.1482174', '-3.4383637');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('94', 'Zhongxi', '2020-09-08', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '1', NULL, 'Israel', '5', '114.1237079', '22.5346419');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('95', 'Osório', '2022-08-28', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', '1', NULL, 'India', '2', '-50.247365', '-29.899528');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('96', 'Gonghe', '2019-06-02', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '1', NULL, 'Romania', '4', '100.620031', '36.284107');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('97', 'Sanqiao', '2020-05-15', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '0', NULL, 'Uruguay', '3', '107.77215', '34.943098');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('98', 'Pugeran', '2020-09-09', 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', '1', NULL, 'Belgium', '1', '110.7465164', '-7.7037789');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('99', 'Peyima', '2022-03-04', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '1', NULL, 'Indonesia', '6', '-11.044307', '8.7550575');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('100', 'Jablonné nad Orlicí', '2019-08-29', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '0', NULL, 'Austria', '7', '16.6005976', '50.0296342');

INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('1', 'Rallying for Rights', '2024-02-24', 'Fusce posuere felis sed lacus.', '4', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('2', 'Gathering for Equality', '2023-06-13', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.', '5', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('3', 'Demanding Justice Now', '2023-03-15', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', '2', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('4', 'Gathering for Equality', '2024-03-11', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('5', 'Rallying for Rights', '2023-05-12', 'Aenean sit amet justo.', '7', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('6', 'Gathering for Equality', '2023-11-25', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '10', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('7', 'Gathering for Equality', '2023-10-31', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '1', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('8', 'Gathering for Equality', '2023-09-04', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.', '4', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('9', 'Stand Up Against Oppression', '2024-04-01', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '7', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('10', 'Rallying for Rights', '2023-04-22', 'Aliquam sit amet diam in magna bibendum imperdiet.', '4', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('11', 'Peaceful Protest Strategies', '2023-03-07', 'Nullam porttitor lacus at turpis.', '10', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('12', 'Unity in Action', '2023-11-28', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', '7', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('13', 'Gathering for Equality', '2024-01-09', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '6', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('14', 'Protest Planning 101', '2023-02-19', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '5', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('15', 'Unity in Action', '2024-02-12', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', '9', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('16', 'Gathering for Equality', '2024-05-31', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('17', 'Stand Up Against Oppression', '2023-11-09', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '10', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('18', 'Rallying for Rights', '2023-06-18', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.', '6', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('19', 'Inquiring Minds Unite', '2024-01-26', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('20', 'Inquiring Minds Unite', '2024-05-29', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', '8', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('21', 'Demanding Justice Now', '2023-10-09', 'Duis ac nibh.', '2', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('22', 'Stand Up Against Oppression', '2023-03-01', 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', '2', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('23', 'Voices of Change', '2023-07-23', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('24', 'March Against Injustice', '2023-02-09', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', '6', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('25', 'Demanding Justice Now', '2023-03-04', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '9', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('26', 'Stand Up Against Oppression', '2023-06-07', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '5', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('27', 'Rallying for Rights', '2024-04-14', 'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', '4', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('28', 'Voices of Change', '2024-02-28', 'Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '5', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('29', 'Peaceful Protest Strategies', '2023-07-07', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '1', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('30', 'Protest Planning 101', '2024-05-24', 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', '3', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('31', 'Inquiring Minds Unite', '2023-04-16', 'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '6', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('32', 'March Against Injustice', '2024-02-09', 'Duis at velit eu est congue elementum.', '3', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('33', 'March Against Injustice', '2023-07-15', 'Nunc rhoncus dui vel sem.', '10', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('34', 'Protest Planning 101', '2024-01-18', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.', '3', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('35', 'Peaceful Protest Strategies', '2023-01-25', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('36', 'Rallying for Rights', '2023-06-16', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('37', 'Unity in Action', '2023-04-28', 'Donec posuere metus vitae ipsum. Aliquam non mauris.', '6', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('38', 'Protest Planning 101', '2023-05-06', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '2', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('39', 'Inquiring Minds Unite', '2023-05-23', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '9', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('40', 'Gathering for Equality', '2024-04-25', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', '2', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('41', 'Stand Up Against Oppression', '2023-06-06', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '5', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('42', 'Protest Planning 101', '2023-04-30', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '6', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('43', 'Inquiring Minds Unite', '2023-05-25', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', '10', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('44', 'Protest Planning 101', '2024-04-02', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '2', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('45', 'Stand Up Against Oppression', '2023-02-27', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '4', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('46', 'Voices of Change', '2023-07-16', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '6', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('47', 'Peaceful Protest Strategies', '2024-04-01', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna.', '8', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('48', 'Voices of Change', '2024-05-28', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo.', '3', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('49', 'Gathering for Equality', '2023-01-05', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '10', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('50', 'Inquiring Minds Unite', '2024-05-09', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '8', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('51', 'Peaceful Protest Strategies', '2024-05-01', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '7', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('52', 'Protest Planning 101', '2023-04-09', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '1', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('53', 'Unity in Action', '2023-05-23', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '10', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('54', 'Peaceful Protest Strategies', '2023-05-11', 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', '4', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('55', 'Inquiring Minds Unite', '2024-02-05', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.', '10', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('56', 'Stand Up Against Oppression', '2023-12-06', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('57', 'March Against Injustice', '2023-03-30', 'Nulla facilisi.', '2', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('58', 'March Against Injustice', '2023-04-10', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', '9', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('59', 'Rallying for Rights', '2023-06-05', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', '2', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('60', 'Peaceful Protest Strategies', '2023-08-27', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus.', '4', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('61', 'Protest Planning 101', '2023-08-19', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '10', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('62', 'Gathering for Equality', '2024-05-02', 'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.', '9', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('63', 'Demanding Justice Now', '2024-02-05', 'Phasellus sit amet erat.', '6', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('64', 'Unity in Action', '2023-06-11', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '2', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('65', 'Rallying for Rights', '2023-03-18', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', '9', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('66', 'Inquiring Minds Unite', '2024-02-09', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '3', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('67', 'Peaceful Protest Strategies', '2023-01-18', 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('68', 'Inquiring Minds Unite', '2023-03-28', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.', '9', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('69', 'Inquiring Minds Unite', '2024-01-09', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('70', 'Voices of Change', '2024-01-01', 'Suspendisse potenti.', '2', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('71', 'Stand Up Against Oppression', '2023-05-31', 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '6', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('72', 'Unity in Action', '2023-11-17', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', '3', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('73', 'Stand Up Against Oppression', '2023-01-01', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '2', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('74', 'Voices of Change', '2024-03-01', 'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', '3', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('75', 'Voices of Change', '2023-06-22', 'Pellentesque at nulla.', '7', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('76', 'Stand Up Against Oppression', '2023-04-24', 'Proin eu mi.', '5', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('77', 'Inquiring Minds Unite', '2024-03-01', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '10', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('78', 'Inquiring Minds Unite', '2023-09-26', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('79', 'Gathering for Equality', '2024-02-08', 'Integer tincidunt ante vel ipsum.', '9', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('80', 'Protest Planning 101', '2023-06-13', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '3', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('81', 'Demanding Justice Now', '2023-06-14', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '10', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('82', 'March Against Injustice', '2024-01-08', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '10', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('83', 'Rallying for Rights', '2023-02-20', 'Aliquam sit amet diam in magna bibendum imperdiet.', '6', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('84', 'Protest Planning 101', '2023-02-28', 'Aliquam quis turpis eget elit sodales scelerisque.', '5', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('85', 'Gathering for Equality', '2023-05-27', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', '9', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('86', 'Protest Planning 101', '2023-05-19', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '8', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('87', 'March Against Injustice', '2023-11-03', 'Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '6', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('88', 'Unity in Action', '2023-08-04', 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '9', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('89', 'Stand Up Against Oppression', '2024-04-13', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '2', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('90', 'Demanding Justice Now', '2024-01-12', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '10', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('91', 'March Against Injustice', '2023-01-29', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', '3', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('92', 'Rallying for Rights', '2023-10-28', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl.', '6', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('93', 'Gathering for Equality', '2023-02-14', 'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '4', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('94', 'Peaceful Protest Strategies', '2024-03-03', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '7', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('95', 'Stand Up Against Oppression', '2024-02-10', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', '6', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('96', 'Peaceful Protest Strategies', '2023-09-28', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('97', 'Unity in Action', '2023-06-08', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', '8', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('98', 'Stand Up Against Oppression', '2023-09-09', 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', '9', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('99', 'Peaceful Protest Strategies', '2023-06-08', 'Sed accumsan felis. Ut at dolor quis odio consequat varius.', '2', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('100', 'Inquiring Minds Unite', '2023-10-25', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.', '3', '3');

INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('1', '4', '68', 'Etiam justo.', '2021-01-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('2', '9', '92', 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', '2021-10-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('3', '7', '69', 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '2023-10-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('4', '1', '95', 'Aenean lectus.', '2021-03-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('5', '10', '42', 'Suspendisse potenti.', '2023-08-03');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('6', '8', '72', 'Pellentesque eget nunc.', '2021-11-01');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('7', '4', '30', 'Etiam pretium iaculis justo.', '2020-06-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('8', '5', '52', 'Duis consequat dui nec nisi volutpat eleifend.', '2019-11-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('9', '10', '82', 'Fusce consequat.', '2019-07-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('10', '1', '97', 'Integer a nibh. In quis justo.', '2024-04-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('11', '3', '75', 'Nulla justo.', '2020-07-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('12', '7', '48', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', '2023-03-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('13', '10', '92', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', '2020-06-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('14', '6', '69', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2023-09-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('15', '2', '10', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', '2020-07-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('16', '3', '99', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', '2022-10-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('17', '5', '65', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', '2021-11-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('18', '7', '15', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '2020-05-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('19', '3', '47', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2023-04-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('20', '4', '87', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.', '2019-01-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('21', '5', '16', 'Integer tincidunt ante vel ipsum.', '2021-01-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('22', '9', '49', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', '2023-07-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('23', '2', '23', 'In sagittis dui vel nisl.', '2021-06-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('24', '1', '21', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2021-01-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('25', '5', '49', 'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.', '2023-08-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('26', '10', '51', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '2024-01-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('27', '7', '53', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '2019-10-16');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('28', '2', '2', 'Duis aliquam convallis nunc.', '2019-01-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('29', '9', '37', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '2019-07-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('30', '4', '91', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', '2021-12-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('31', '4', '30', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2020-11-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('32', '2', '14', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', '2023-08-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('33', '5', '10', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '2023-10-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('34', '8', '39', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '2023-07-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('35', '7', '32', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', '2020-03-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('36', '9', '4', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '2024-04-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('37', '10', '91', 'Nulla ut erat id mauris vulputate elementum.', '2023-01-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('38', '9', '61', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', '2021-09-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('39', '1', '20', 'Nulla nisl.', '2021-07-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('40', '4', '64', 'Ut tellus.', '2021-07-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('41', '6', '4', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '2020-03-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('42', '5', '23', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna.', '2020-03-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('43', '8', '79', 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', '2023-04-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('44', '5', '57', 'Nulla tellus.', '2019-07-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('45', '2', '68', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '2019-03-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('46', '9', '64', 'Suspendisse potenti.', '2023-01-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('47', '3', '55', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', '2023-09-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('48', '6', '37', 'Sed ante.', '2019-02-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('49', '2', '49', 'Cras in purus eu magna vulputate luctus.', '2019-01-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('50', '6', '42', 'In hac habitasse platea dictumst.', '2023-07-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('51', '4', '28', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '2019-01-03');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('52', '9', '95', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', '2020-12-16');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('53', '10', '22', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', '2020-03-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('54', '3', '50', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', '2019-12-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('55', '7', '58', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', '2021-08-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('56', '2', '43', 'Quisque porta volutpat erat.', '2022-10-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('57', '6', '100', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', '2020-09-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('58', '1', '3', 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.', '2020-09-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('59', '3', '99', 'Pellentesque ultrices mattis odio. Donec vitae nisi.', '2020-05-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('60', '8', '57', 'Donec posuere metus vitae ipsum.', '2021-07-03');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('61', '1', '19', 'In congue.', '2019-01-01');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('62', '6', '29', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2021-05-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('63', '3', '60', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '2023-09-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('64', '7', '67', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', '2021-09-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('65', '8', '36', 'Morbi ut odio.', '2020-11-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('66', '4', '33', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '2021-10-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('67', '7', '76', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '2020-08-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('68', '6', '74', 'Donec ut dolor.', '2019-01-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('69', '4', '50', 'In hac habitasse platea dictumst.', '2022-03-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('70', '2', '6', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2024-04-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('71', '1', '49', 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', '2019-11-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('72', '5', '52', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', '2021-12-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('73', '9', '81', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '2020-02-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('74', '8', '40', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', '2022-06-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('75', '3', '87', 'Suspendisse potenti.', '2022-05-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('76', '5', '17', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '2021-02-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('77', '10', '95', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', '2022-02-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('78', '4', '100', 'Integer tincidunt ante vel ipsum.', '2020-10-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('79', '10', '34', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '2019-10-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('80', '4', '67', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2023-11-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('81', '1', '46', 'Integer tincidunt ante vel ipsum.', '2022-10-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('82', '6', '44', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', '2023-03-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('83', '9', '10', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', '2022-06-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('84', '2', '92', 'Pellentesque at nulla. Suspendisse potenti.', '2022-02-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('85', '3', '15', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', '2021-04-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('86', '10', '6', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', '2020-07-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('87', '4', '4', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', '2020-01-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('88', '5', '70', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', '2019-05-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('89', '7', '71', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', '2020-06-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('90', '8', '98', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', '2019-03-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('91', '7', '54', 'Nunc nisl.', '2023-06-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('92', '6', '26', 'Praesent blandit.', '2020-10-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('93', '2', '72', 'Aliquam quis turpis eget elit sodales scelerisque.', '2022-04-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('94', '5', '46', 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', '2019-07-31');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('95', '4', '61', 'Nunc purus.', '2019-05-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('96', '1', '31', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '2021-04-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('97', '7', '22', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '2019-02-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('98', '3', '78', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', '2019-03-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('99', '10', '97', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '2020-05-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('100', '1', '18', 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '2022-06-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('101', '4', '43', 'Sed ante. Vivamus tortor.', '2019-01-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('102', '5', '87', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2022-07-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('103', '1', '91', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', '2022-10-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('104', '7', '2', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '2020-09-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('105', '4', '10', 'Donec posuere metus vitae ipsum.', '2022-10-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('106', '8', '25', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.', '2022-11-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('107', '6', '70', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.', '2022-08-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('108', '3', '18', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '2023-02-03');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('109', '8', '62', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2021-06-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('110', '1', '91', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', '2019-06-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('111', '4', '55', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '2023-03-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('112', '5', '34', 'Fusce consequat. Nulla nisl.', '2019-10-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('113', '6', '31', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '2021-08-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('114', '7', '73', 'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', '2020-12-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('115', '3', '6', 'Aliquam non mauris.', '2023-02-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('116', '8', '98', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '2023-10-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('117', '9', '19', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.', '2023-01-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('118', '2', '12', 'In est risus, auctor sed, tristique in, tempus sit amet, sem.', '2023-04-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('119', '4', '49', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '2023-09-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('120', '6', '77', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '2023-02-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('121', '1', '41', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2021-05-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('122', '7', '93', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '2022-04-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('123', '10', '25', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '2021-04-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('124', '6', '36', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', '2021-09-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('125', '9', '48', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '2022-07-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('126', '8', '95', 'Curabitur at ipsum ac tellus semper interdum.', '2022-02-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('127', '3', '2', 'Maecenas tincidunt lacus at velit.', '2022-02-16');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('128', '8', '70', 'Fusce consequat. Nulla nisl. Nunc nisl.', '2023-03-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('129', '4', '86', 'Sed accumsan felis.', '2019-06-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('130', '10', '5', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '2022-12-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('131', '6', '80', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', '2019-09-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('132', '5', '60', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2021-08-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('133', '1', '21', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '2020-01-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('134', '10', '36', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '2019-01-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('135', '8', '40', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', '2020-06-01');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('136', '6', '53', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '2020-03-31');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('137', '7', '74', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '2019-11-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('138', '4', '58', 'Curabitur gravida nisi at nibh.', '2019-08-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('139', '6', '88', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', '2021-10-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('140', '7', '48', 'Donec posuere metus vitae ipsum.', '2019-12-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('141', '9', '26', 'Integer ac leo.', '2022-11-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('142', '3', '70', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', '2020-10-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('143', '5', '61', 'Fusce consequat. Nulla nisl. Nunc nisl.', '2023-01-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('144', '2', '53', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', '2021-05-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('145', '9', '50', 'Nullam porttitor lacus at turpis.', '2019-11-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('146', '7', '86', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '2023-11-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('147', '2', '47', 'In eleifend quam a odio. In hac habitasse platea dictumst.', '2019-01-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('148', '10', '36', 'Etiam justo. Etiam pretium iaculis justo.', '2019-07-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('149', '4', '97', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2023-11-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('150', '5', '20', 'Ut tellus.', '2020-06-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('151', '4', '21', 'Morbi porttitor lorem id ligula.', '2022-06-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('152', '10', '10', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2024-03-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('153', '1', '46', 'Nulla mollis molestie lorem.', '2020-12-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('154', '2', '92', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2021-10-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('155', '9', '13', 'Proin at turpis a pede posuere nonummy. Integer non velit.', '2019-04-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('156', '3', '54', 'Proin eu mi. Nulla ac enim.', '2023-01-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('157', '2', '71', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '2019-10-31');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('158', '4', '40', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '2023-02-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('159', '1', '96', 'In sagittis dui vel nisl.', '2022-10-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('160', '9', '51', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '2022-04-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('161', '8', '99', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', '2019-04-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('162', '6', '54', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', '2020-09-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('163', '8', '95', 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', '2021-01-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('164', '6', '80', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', '2020-08-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('165', '4', '32', 'Curabitur in libero ut massa volutpat convallis.', '2020-07-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('166', '3', '94', 'In congue.', '2021-08-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('167', '5', '18', 'Proin risus.', '2020-08-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('168', '1', '12', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2022-06-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('169', '4', '37', 'In congue. Etiam justo.', '2023-04-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('170', '1', '20', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '2021-12-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('171', '8', '31', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '2020-03-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('172', '2', '51', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.', '2024-03-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('173', '5', '34', 'Praesent lectus.', '2023-01-31');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('174', '7', '93', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', '2019-04-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('175', '4', '64', 'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.', '2020-07-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('176', '3', '35', 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.', '2020-05-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('177', '6', '15', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', '2019-08-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('178', '5', '84', 'Pellentesque at nulla. Suspendisse potenti.', '2024-05-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('179', '2', '46', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', '2022-02-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('180', '9', '92', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', '2021-04-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('181', '10', '23', 'Aenean lectus. Pellentesque eget nunc.', '2022-09-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('182', '5', '17', 'Quisque id justo sit amet sapien dignissim vestibulum.', '2021-02-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('183', '2', '33', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis.', '2020-01-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('184', '3', '43', 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', '2023-08-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('185', '1', '87', 'Duis bibendum.', '2022-10-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('186', '7', '21', 'Vestibulum ac est lacinia nisi venenatis tristique.', '2020-02-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('187', '5', '20', 'Morbi porttitor lorem id ligula.', '2021-08-01');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('188', '2', '76', 'Quisque ut erat. Curabitur gravida nisi at nibh.', '2019-12-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('189', '4', '45', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '2020-03-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('190', '6', '46', 'Aenean auctor gravida sem.', '2019-08-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('191', '1', '37', 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', '2022-06-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('192', '3', '24', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', '2021-05-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('193', '8', '72', 'Nulla tellus.', '2019-05-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('194', '10', '97', 'Pellentesque viverra pede ac diam.', '2021-11-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('195', '9', '69', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2021-06-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('196', '7', '75', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2021-09-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('197', '6', '60', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '2023-09-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('198', '10', '40', 'Donec posuere metus vitae ipsum. Aliquam non mauris.', '2022-07-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('199', '1', '47', 'Duis ac nibh.', '2021-10-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('200', '3', '30', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', '2020-01-31');

INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('1', 'March for Justice', 'Hermy', 'Cassie', '2022-12-01', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('2', 'Voices of Change', 'Denny', 'Britee', '2016-04-20', 'The Sentinel Sun');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('3', 'Protest Perspectives', 'Melanie', 'Meak', '2017-11-29', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('4', 'Rally Reflections', 'Robinette', 'Hann', '2018-11-07', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('5', 'Activism Chronicles', 'Jephthah', 'Rawe', '2018-01-27', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('6', 'Rebellion Reports', 'Ramsay', 'Dryden', '2022-03-03', 'The Observer News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('7', 'Demonstration Diaries', 'Starlin', 'Grenter', '2020-06-12', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('8', 'Revolution Reviews', 'Conni', 'Mathivon', '2017-05-05', 'The Daily News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('9', 'Uprising Updates', 'Marlene', 'Tomaszczyk', '2021-03-20', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('10', 'Resistance Recaps', 'Nevsa', 'Keeney', '2022-11-12', 'The Sunday Times');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('11', 'Protest Pulse', 'Aurore', 'Paik', '2015-10-26', 'The Press Journal');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('12', 'Marching Manifesto', 'Trefor', 'Poolton', '2015-03-09', 'The Daily News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('13', 'Outcry Observations', 'Hyatt', 'Shurrock', '2016-12-24', 'The Observer News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('14', 'Protestor Profiles', 'Esdras', 'Coultish', '2023-09-26', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('15', 'Protest Placards', 'Andrei', 'Lanfranchi', '2017-03-13', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('16', 'Protest Poetry', 'Kaleena', 'Faichney', '2021-05-12', 'The Daily News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('17', 'Protest Power', 'Elbertina', 'O''Siaghail', '2023-08-28', 'The Press Journal');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('18', 'Protest Platform', 'Chiquita', 'Durrad', '2021-12-02', 'The Weekly Herald');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('19', 'Protest Progress', 'Prue', 'Puleque', '2015-05-18', 'The Observer News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('20', 'Protest Press', 'Richard', 'Marchant', '2021-10-13', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('21', 'March for Justice', 'Jake', 'Goding', '2022-05-10', 'The Chronicle Tribune');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('22', 'Voices of Change', 'Davide', 'Benedict', '2022-01-20', 'The Press Journal');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('23', 'Protest Perspectives', 'Alard', 'Scarsbrick', '2020-02-15', 'The Evening Gazette');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('24', 'Rally Reflections', 'Quent', 'Martino', '2022-08-02', 'The Weekly Herald');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('25', 'Activism Chronicles', 'Juditha', 'Cajkler', '2023-09-05', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('26', 'Rebellion Reports', 'Mandi', 'Snar', '2020-07-12', 'The Press Journal');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('27', 'Demonstration Diaries', 'Lotta', 'Blaxley', '2017-09-09', 'The Sentinel Sun');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('28', 'Revolution Reviews', 'Dyna', 'McCoish', '2018-03-29', 'The Sentinel Sun');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('29', 'Uprising Updates', 'Dynah', 'Bailes', '2023-08-23', 'The Chronicle Tribune');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('30', 'Resistance Recaps', 'Webster', 'Ceaser', '2022-10-04', 'The Gazette Express');

INSERT INTO protest_attendence (user, protest) VALUES ('6', '29');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '80');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '73');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '10');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '46');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '41');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '19');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '71');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '24');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '56');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '29');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '82');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '48');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '53');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '77');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '63');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '11');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '57');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '68');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '64');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '44');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '72');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '94');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '24');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '87');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '66');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '27');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '30');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '10');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '21');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '66');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '41');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '35');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '3');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '88');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '41');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '10');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '25');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '2');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '29');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '23');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '48');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '22');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '89');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '47');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '58');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '91');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '63');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '24');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '75');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '12');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '59');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '18');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '84');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '60');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '4');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '3');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '12');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '54');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '93');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '7');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '56');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '25');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '7');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '32');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '36');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '27');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '38');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '53');
INSERT INTO protest_attendence (user, protest) VALUES ('5', '42');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '99');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '13');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '17');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '48');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '16');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '43');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '94');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '23');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '34');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '27');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '72');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '32');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '16');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '89');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '74');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '91');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '86');
INSERT INTO protest_attendence (user, protest) VALUES ('5', '23');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '21');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '93');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '76');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '77');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '45');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '72');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '19');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '55');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '93');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '8');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '74');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '27');

INSERT INTO protest_likes (user, protest) VALUES ('5', '72');
INSERT INTO protest_likes (user, protest) VALUES ('6', '31');
INSERT INTO protest_likes (user, protest) VALUES ('7', '99');
INSERT INTO protest_likes (user, protest) VALUES ('5', '55');
INSERT INTO protest_likes (user, protest) VALUES ('2', '28');
INSERT INTO protest_likes (user, protest) VALUES ('5', '91');
INSERT INTO protest_likes (user, protest) VALUES ('7', '35');
INSERT INTO protest_likes (user, protest) VALUES ('10', '50');
INSERT INTO protest_likes (user, protest) VALUES ('2', '96');
INSERT INTO protest_likes (user, protest) VALUES ('7', '50');
INSERT INTO protest_likes (user, protest) VALUES ('9', '86');
INSERT INTO protest_likes (user, protest) VALUES ('7', '72');
INSERT INTO protest_likes (user, protest) VALUES ('8', '3');
INSERT INTO protest_likes (user, protest) VALUES ('8', '74');
INSERT INTO protest_likes (user, protest) VALUES ('10', '93');
INSERT INTO protest_likes (user, protest) VALUES ('1', '27');
INSERT INTO protest_likes (user, protest) VALUES ('5', '17');
INSERT INTO protest_likes (user, protest) VALUES ('7', '47');
INSERT INTO protest_likes (user, protest) VALUES ('9', '59');
INSERT INTO protest_likes (user, protest) VALUES ('5', '56');

INSERT INTO user_interests (user, interests) VALUES ('5', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('9', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('2', 'parties');
INSERT INTO user_interests (user, interests) VALUES ('9', 'political ideologies');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('4', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political violence');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political ideologies');
INSERT INTO user_interests (user, interests) VALUES ('6', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('4', 'protesters');
INSERT INTO user_interests (user, interests) VALUES ('9', 'political activism');
INSERT INTO user_interests (user, interests) VALUES ('4', 'grassroots movements');
INSERT INTO user_interests (user, interests) VALUES ('9', 'political reform');
INSERT INTO user_interests (user, interests) VALUES ('6', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('6', 'voters');
INSERT INTO user_interests (user, interests) VALUES ('7', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('10', 'politics');
INSERT INTO user_interests (user, interests) VALUES ('6', 'political ideologies');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political history');
INSERT INTO user_interests (user, interests) VALUES ('9', 'elections');
INSERT INTO user_interests (user, interests) VALUES ('10', 'political reform');
INSERT INTO user_interests (user, interests) VALUES ('5', 'political science');
INSERT INTO user_interests (user, interests) VALUES ('1', 'legislation');
INSERT INTO user_interests (user, interests) VALUES ('6', 'voting');
INSERT INTO user_interests (user, interests) VALUES ('9', 'social justice');
INSERT INTO user_interests (user, interests) VALUES ('4', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('7', 'political activism');
INSERT INTO user_interests (user, interests) VALUES ('6', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political history');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political science');
INSERT INTO user_interests (user, interests) VALUES ('4', 'politics');
INSERT INTO user_interests (user, interests) VALUES ('1', 'rallies');
INSERT INTO user_interests (user, interests) VALUES ('4', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('10', 'rallies');
INSERT INTO user_interests (user, interests) VALUES ('5', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('3', 'protesters');
INSERT INTO user_interests (user, interests) VALUES ('6', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('7', 'protesters');
INSERT INTO user_interests (user, interests) VALUES ('5', 'rallies');
INSERT INTO user_interests (user, interests) VALUES ('6', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('2', 'protesters');
INSERT INTO user_interests (user, interests) VALUES ('2', 'parties');
INSERT INTO user_interests (user, interests) VALUES ('10', 'elections');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political ideologies');
INSERT INTO user_interests (user, interests) VALUES ('9', 'elections');
INSERT INTO user_interests (user, interests) VALUES ('4', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('8', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('4', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('9', 'parties');
INSERT INTO user_interests (user, interests) VALUES ('3', 'policy');
INSERT INTO user_interests (user, interests) VALUES ('8', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political campaigns');
INSERT INTO user_interests (user, interests) VALUES ('9', 'government');
INSERT INTO user_interests (user, interests) VALUES ('4', 'voters');
INSERT INTO user_interests (user, interests) VALUES ('5', 'government');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('4', 'social justice');
INSERT INTO user_interests (user, interests) VALUES ('10', 'politics');
INSERT INTO user_interests (user, interests) VALUES ('5', 'demonstrations');
INSERT INTO user_interests (user, interests) VALUES ('3', 'parties');
INSERT INTO user_interests (user, interests) VALUES ('1', 'political science');
INSERT INTO user_interests (user, interests) VALUES ('5', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('5', 'grassroots movements');
INSERT INTO user_interests (user, interests) VALUES ('7', 'legislation');
INSERT INTO user_interests (user, interests) VALUES ('2', 'campaigns');
INSERT INTO user_interests (user, interests) VALUES ('9', 'social justice');
INSERT INTO user_interests (user, interests) VALUES ('4', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('10', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('5', 'policy');
INSERT INTO user_interests (user, interests) VALUES ('8', 'protests');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political theory');
INSERT INTO user_interests (user, interests) VALUES ('5', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('4', 'activism');
INSERT INTO user_interests (user, interests) VALUES ('6', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('4', 'activism');
INSERT INTO user_interests (user, interests) VALUES ('3', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('10', 'political history');
INSERT INTO user_interests (user, interests) VALUES ('8', 'campaigns');
INSERT INTO user_interests (user, interests) VALUES ('5', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('7', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('4', 'activism');
INSERT INTO user_interests (user, interests) VALUES ('7', 'grassroots movements');
INSERT INTO user_interests (user, interests) VALUES ('9', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('10', 'campaigns');
INSERT INTO user_interests (user, interests) VALUES ('7', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('8', 'elections');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political science');
INSERT INTO user_interests (user, interests) VALUES ('1', 'political activism');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('10', 'demonstrations');
INSERT INTO user_interests (user, interests) VALUES ('7', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('1', 'activism');
INSERT INTO user_interests (user, interests) VALUES ('3', 'government');
INSERT INTO user_interests (user, interests) VALUES ('7', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('4', 'social justice');
INSERT INTO user_interests (user, interests) VALUES ('9', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('6', 'voters');
INSERT INTO user_interests (user, interests) VALUES ('2', 'politics');
INSERT INTO user_interests (user, interests) VALUES ('10', 'political campaigns');

INSERT INTO news_likes (user, news_article) VALUES ('6', '10');
INSERT INTO news_likes (user, news_article) VALUES ('3', '5');
INSERT INTO news_likes (user, news_article) VALUES ('7', '30');
INSERT INTO news_likes (user, news_article) VALUES ('9', '9');
INSERT INTO news_likes (user, news_article) VALUES ('9', '18');
INSERT INTO news_likes (user, news_article) VALUES ('1', '29');
INSERT INTO news_likes (user, news_article) VALUES ('9', '24');
INSERT INTO news_likes (user, news_article) VALUES ('7', '15');
INSERT INTO news_likes (user, news_article) VALUES ('9', '24');
INSERT INTO news_likes (user, news_article) VALUES ('7', '26');
INSERT INTO news_likes (user, news_article) VALUES ('3', '25');
INSERT INTO news_likes (user, news_article) VALUES ('10', '12');
INSERT INTO news_likes (user, news_article) VALUES ('4', '21');
INSERT INTO news_likes (user, news_article) VALUES ('9', '3');
INSERT INTO news_likes (user, news_article) VALUES ('4', '1');
INSERT INTO news_likes (user, news_article) VALUES ('1', '11');
INSERT INTO news_likes (user, news_article) VALUES ('10', '27');
INSERT INTO news_likes (user, news_article) VALUES ('10', '24');
INSERT INTO news_likes (user, news_article) VALUES ('6', '20');
INSERT INTO news_likes (user, news_article) VALUES ('7', '22');
