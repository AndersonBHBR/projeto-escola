CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role ENUM('admin', 'teacher', 'student'),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    created_by INT NULL,
    updated_by INT NULL,
    deleted_by INT NULL
,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (deleted_by) REFERENCES users(id)
);

CREATE TABLE classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_by INT NULL,
    updated_by INT NULL,
    deleted_by INT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (deleted_by) REFERENCES users(id)
);


CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_by INT NULL,
    updated_by INT NULL,
    deleted_by INT NULL,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (deleted_by) REFERENCES users(id)
);


CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,  -- ID do aluno
    class_id INT,  -- ID da turma
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    created_by INT NULL,
    updated_by INT NULL,
    deleted_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (class_id) REFERENCES classes(id)
,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (deleted_by) REFERENCES users(id)
);

CREATE TABLE grades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,  -- ID do aluno
    subject_id INT,  -- ID da disciplina
    teacher_id INT,  -- ID do professor que lançou a nota
    class_id INT,    -- ID da turma
    grade DECIMAL(5, 2),  -- Nota do aluno
    term ENUM('1', '2', '3', '4'),  -- Bimestre
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    created_by INT NULL,
    updated_by INT NULL,
    deleted_by INT,
    FOREIGN KEY (student_id) REFERENCES users(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (teacher_id) REFERENCES users(id),
    FOREIGN KEY (class_id) REFERENCES classes(id)
,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    FOREIGN KEY (deleted_by) REFERENCES users(id)
);

-- Inserindo disciplinas
INSERT INTO subjects (name) VALUES
    ('Matemática'),
    ('Física'),
    ('Química'),
    ('Biologia'),
    ('História'),
    ('Geografia'),
    ('Português'),
    ('Inglês'),
    ('Educação Física')
;


-- Inserindo turmas
INSERT INTO classes (name) VALUES 
    ('1º Ano A'),
    ('1º Ano B'),
    ('2º Ano A'),
    ('2º Ano B'),
    ('3º Ano A'),
    ('3º Ano B')
;


-- Inserindo alunos
-- Inserindo 120 alunos com nomes e sobrenomes aleatórios
INSERT INTO users (name, email, password, role) VALUES 
    ('Lucas Pereira', 'lucas.pereira@escola.com', 'senhaAluno', 'student'),
    ('Mariana Fernandes', 'mariana.fernandes@escola.com', 'senhaAluno', 'student'),
    ('Gustavo Costa', 'gustavo.costa@escola.com', 'senhaAluno', 'student'),
    ('Amanda Lima', 'amanda.lima@escola.com', 'senhaAluno', 'student'),
    ('Felipe Almeida', 'felipe.almeida@escola.com', 'senhaAluno', 'student'),
    ('Carolina Silva', 'carolina.silva@escola.com', 'senhaAluno', 'student'),
    ('Bruno Sousa', 'bruno.sousa@escola.com', 'senhaAluno', 'student'),
    ('Juliana Martins', 'juliana.martins@escola.com', 'senhaAluno', 'student'),
    ('Rafael Oliveira', 'rafael.oliveira@escola.com', 'senhaAluno', 'student'),
    ('Larissa Gomes', 'larissa.gomes@escola.com', 'senhaAluno', 'student'),
    ('Daniel Souza', 'daniel.souza@escola.com', 'senhaAluno', 'student'),
    ('Paula Ribeiro', 'paula.ribeiro@escola.com', 'senhaAluno', 'student'),
    ('Rodrigo Carvalho', 'rodrigo.carvalho@escola.com', 'senhaAluno', 'student'),
    ('Aline Fernandes', 'aline.fernandes@escola.com', 'senhaAluno', 'student'),
    ('Mateus Costa', 'mateus.costa@escola.com', 'senhaAluno', 'student'),
    ('Isabela Martins', 'isabela.martins@escola.com', 'senhaAluno', 'student'),
    ('Vinícius Santos', 'vinicius.santos@escola.com', 'senhaAluno', 'student'),
    ('Natália Silva', 'natalia.silva@escola.com', 'senhaAluno', 'student'),
    ('Henrique Pereira', 'henrique.pereira@escola.com', 'senhaAluno', 'student'),
    ('Bruna Souza', 'bruna.souza@escola.com', 'senhaAluno', 'student'),
    ('Thiago Almeida', 'thiago.almeida@escola.com', 'senhaAluno', 'student'),
    ('Gabriela Lima', 'gabriela.lima@escola.com', 'senhaAluno', 'student'),
    ('Lucas Santos', 'lucas.santos@escola.com', 'senhaAluno', 'student'),
    ('Marcela Oliveira', 'marcela.oliveira@escola.com', 'senhaAluno', 'student'),
    ('Ricardo Costa', 'ricardo.costa@escola.com', 'senhaAluno', 'student'),
    ('Fernanda Silva', 'fernanda.silva@escola.com', 'senhaAluno', 'student'),
    ('Leonardo Pereira', 'leonardo.pereira@escola.com', 'senhaAluno', 'student'),
    ('Sofia Carvalho', 'sofia.carvalho@escola.com', 'senhaAluno', 'student'),
    ('André Fernandes', 'andre.fernandes@escola.com', 'senhaAluno', 'student'),
    ('Manuela Souza', 'manuela.souza@escola.com', 'senhaAluno', 'student'),
    ('Eduardo Mendes', 'eduardo.mendes@escola.com', 'senhaAluno', 'student'),
    ('Camila Rocha', 'camila.rocha@escola.com', 'senhaAluno', 'student'),
    ('Lucas Azevedo', 'lucas.azevedo@escola.com', 'senhaAluno', 'student'),
    ('Sabrina Oliveira', 'sabrina.oliveira@escola.com', 'senhaAluno', 'student'),
    ('Ricardo Farias', 'ricardo.farias@escola.com', 'senhaAluno', 'student'),
    ('Larissa Sousa', 'larissa.sousa@escola.com', 'senhaAluno', 'student'),
    ('Victor Lima', 'victor.lima@escola.com', 'senhaAluno', 'student'),
    ('Daniela Alves', 'daniela.alves@escola.com', 'senhaAluno', 'student'),
    ('Renato Ribeiro', 'renato.ribeiro@escola.com', 'senhaAluno', 'student'),
    ('Bruna Ferreira', 'bruna.ferreira@escola.com', 'senhaAluno', 'student'),
    ('Fabio Almeida', 'fabio.almeida@escola.com', 'senhaAluno', 'student'),
    ('Juliana Costa', 'juliana.costa@escola.com', 'senhaAluno', 'student'),
    ('Gabriel Martins', 'gabriel.martins@escola.com', 'senhaAluno', 'student'),
    ('Ana Lima', 'ana.lima@escola.com', 'senhaAluno', 'student'),
    ('Luiz Gonçalves', 'luiz.goncalves@escola.com', 'senhaAluno', 'student'),
    ('Isabel Silva', 'isabel.silva@escola.com', 'senhaAluno', 'student'),
    ('Paulo Souza', 'paulo.souza@escola.com', 'senhaAluno', 'student'),
    ('Beatriz Gomes', 'beatriz.gomes@escola.com', 'senhaAluno', 'student'),
    ('Rodrigo Carvalho', 'rodrigo.carvalho2@escola.com', 'senhaAluno', 'student'),
    ('Tatiana Fernandes', 'tatiana.fernandes@escola.com', 'senhaAluno', 'student'),
    ('Rafael Ribeiro', 'rafael.ribeiro@escola.com', 'senhaAluno', 'student'),
    ('Aline Costa', 'aline.costa@escola.com', 'senhaAluno', 'student'),
    ('Thiago Barbosa', 'thiago.barbosa@escola.com', 'senhaAluno', 'student'),
    ('Fernanda Lima', 'fernanda.lima@escola.com', 'senhaAluno', 'student'),
    ('Mateus Duarte', 'mateus.duarte@escola.com', 'senhaAluno', 'student'),
    ('Carla Mendes', 'carla.mendes@escola.com', 'senhaAluno', 'student'),
    ('Douglas Fernandes', 'douglas.fernandes@escola.com', 'senhaAluno', 'student'),
    ('Mariana Ribeiro', 'mariana.ribeiro@escola.com', 'senhaAluno', 'student'),
    ('Pedro Oliveira', 'pedro.oliveira@escola.com', 'senhaAluno', 'student'),
    ('Patricia Martins', 'patricia.martins@escola.com', 'senhaAluno', 'student'),
    ('Henrique Souza', 'henrique.souza@escola.com', 'senhaAluno', 'student'),
    ('Larissa Carvalho', 'larissa.carvalho@escola.com', 'senhaAluno', 'student'),
    ('Júlio Costa', 'julio.costa@escola.com', 'senhaAluno', 'student'),
    ('Adriana Farias', 'adriana.farias@escola.com', 'senhaAluno', 'student'),
    ('Vinícius Rocha', 'vinicius.rocha@escola.com', 'senhaAluno', 'student'),
    ('Fernanda Silva', 'fernanda.silva2@escola.com', 'senhaAluno', 'student'),
    ('Diogo Barbosa', 'diogo.barbosa@escola.com', 'senhaAluno', 'student'),
    ('Marta Almeida', 'marta.almeida@escola.com', 'senhaAluno', 'student'),
    ('Renan Costa', 'renan.costa@escola.com', 'senhaAluno', 'student'),
    ('Sandra Gomes', 'sandra.gomes@escola.com', 'senhaAluno', 'student'),
    ('José Mendes', 'jose.mendes@escola.com', 'senhaAluno', 'student'),
    ('Márcia Rocha', 'marcia.rocha@escola.com', 'senhaAluno', 'student'),
    ('Felipe Gonçalves', 'felipe.goncalves@escola.com', 'senhaAluno', 'student'),
    ('Rafaela Almeida', 'rafaela.almeida@escola.com', 'senhaAluno', 'student'),
    ('Eduarda Fernandes', 'eduarda.fernandes@escola.com', 'senhaAluno', 'student'),
    ('Leonardo Martins', 'leonardo.martins@escola.com', 'senhaAluno', 'student'),
    ('Alice Costa', 'alice.costa@escola.com', 'senhaAluno', 'student'),
    ('Rogério Ribeiro', 'rogerio.ribeiro@escola.com', 'senhaAluno', 'student'),
    ('Claudia Souza', 'claudia.souza@escola.com', 'senhaAluno', 'student'),
    ('Alex Oliveira', 'alex.oliveira@escola.com', 'senhaAluno', 'student'),
    ('Tatiane Lima', 'tatiane.lima@escola.com', 'senhaAluno', 'student'),
    ('César Mendes', 'cesar.mendes@escola.com', 'senhaAluno', 'student'),
    ('Valéria Gomes', 'valeria.gomes@escola.com', 'senhaAluno', 'student'),
    ('Samuel Costa', 'samuel.costa@escola.com', 'senhaAluno', 'student'),
    ('Jéssica Oliveira', 'jessica.oliveira@escola.com', 'senhaAluno', 'student'),
    ('Fábio Duarte', 'fabio.duarte@escola.com', 'senhaAluno', 'student'),
    ('Luciana Pereira', 'luciana.pereira@escola.com', 'senhaAluno', 'student'),
    ('Márcio Barbosa', 'marcio.barbosa@escola.com', 'senhaAluno', 'student'),
    ('Ingrid Rocha', 'ingrid.rocha@escola.com', 'senhaAluno', 'student'),
    ('Ivan Almeida', 'ivan.almeida@escola.com', 'senhaAluno', 'student'),
    ('Marcelo Costa', 'marcelo.costa@escola.com', 'senhaAluno', 'student'),
    ('Cláudio Silva', 'claudio.silva@escola.com', 'senhaAluno', 'student'),
    ('Vitor Gonçalves', 'vitor.goncalves@escola.com', 'senhaAluno', 'student'),
    ('Simone Ribeiro', 'simone.ribeiro@escola.com', 'senhaAluno', 'student'),
    ('Tânia Fernandes', 'tania.fernandes@escola.com', 'senhaAluno', 'student'),
    ('Sérgio Costa', 'sergio.costa@escola.com', 'senhaAluno', 'student'),
    ('Joana Rocha', 'joana.rocha@escola.com', 'senhaAluno', 'student'),
    ('Fernando Mendes', 'fernando.mendes@escola.com', 'senhaAluno', 'student'),
    ('Nathalia Souza', 'nathalia.souza@escola.com', 'senhaAluno', 'student'),
    ('Milena Silva', 'milena.silva@escola.com', 'senhaAluno', 'student'),
    ('Alessandra Carvalho', 'alessandra.carvalho@escola.com', 'senhaAluno', 'student'),
    ('Guilherme Farias', 'guilherme.farias@escola.com', 'senhaAluno', 'student'),
    ('Regina Martins', 'regina.martins@escola.com', 'senhaAluno', 'student'),
    ('Edson Almeida', 'edson.almeida@escola.com', 'senhaAluno', 'student'),
    ('Valter Pereira', 'valter.pereira@escola.com', 'senhaAluno', 'student'),
    ('Cristiane Costa', 'cristiane.costa@escola.com', 'senhaAluno', 'student'),
    ('Leandro Ribeiro', 'leandro.ribeiro@escola.com', 'senhaAluno', 'student'),
    ('Vivian Gonçalves', 'vivian.goncalves@escola.com', 'senhaAluno', 'student'),
    ('Cíntia Carvalho', 'cintia.carvalho@escola.com', 'senhaAluno', 'student'),
    ('Gisele Farias', 'gisele.farias@escola.com', 'senhaAluno', 'student'),
    ('Alberto Silva', 'alberto.silva@escola.com', 'senhaAluno', 'student'),
    ('Janaina Costa', 'janaina.costa@escola.com', 'senhaAluno', 'student'),
    ('Danilo Rocha', 'danilo.rocha@escola.com', 'senhaAluno', 'student'),
    ('Andressa Pereira', 'andressa.pereira@escola.com', 'senhaAluno', 'student'),
    ('Edilson Mendes', 'edilson.mendes@escola.com', 'senhaAluno', 'student'),
    ('Talita Ribeiro', 'talita.ribeiro@escola.com', 'senhaAluno', 'student'),
    ('Everton Oliveira', 'everton.oliveira@escola.com', 'senhaAluno', 'student'),
    ('Emanuelle Del Amor', 'emanuelle.del.amor@escola.com', 'senhaAluno', 'student'),
    ('Israel de Deus', 'israel.de.deus@escola.com', 'senhaAluno', 'student'),
    ('Zoro One Piece', 'zoro.one.piece@escola.com', 'senhaAluno', 'student')
;

-- Inserindo alunos do 3º Ano A
INSERT INTO users (name, email, password, role) VALUES
    ('Haruto Suzuki', 'haruto.suzuki@escola.com', 'senhaAluno', 'student'),
    ('Rin Nakamura', 'rin.nakamura@escola.com', 'senhaAluno', 'student'),
    ('Yuki Sato', 'yuki.sato@escola.com', 'senhaAluno', 'student'),
    ('Takumi Yamada', 'takumi.yamada@escola.com', 'senhaAluno', 'student'),
    ('Mai Fujimoto', 'mai.fujimoto@escola.com', 'senhaAluno', 'student'),
    ('Sakura Takahashi', 'sakura.takahashi@escola.com', 'senhaAluno', 'student'),
    ('Kenji Aoki', 'kenji.aoki@escola.com', 'senhaAluno', 'student'),
    ('Nana Tanaka', 'nana.tanaka@escola.com', 'senhaAluno', 'student'),
    ('Ryo Ito', 'ryo.ito@escola.com', 'senhaAluno', 'student'),
    ('Ayumi Yamamoto', 'ayumi.yamamoto@escola.com', 'senhaAluno', 'student'),
    ('Kaito Kobayashi', 'kaito.kobayashi@escola.com', 'senhaAluno', 'student'),
    ('Emi Shimizu', 'emi.shimizu@escola.com', 'senhaAluno', 'student'),
    ('Sora Ogawa', 'sora.ogawa@escola.com', 'senhaAluno', 'student'),
    ('Hinata Kudo', 'hinata.kudo@escola.com', 'senhaAluno', 'student'),
    ('Kazuya Mori', 'kazuya.mori@escola.com', 'senhaAluno', 'student'),
    ('Miyu Okada', 'miyu.okada@escola.com', 'senhaAluno', 'student'),
    ('Sho Nakajima', 'sho.nakajima@escola.com', 'senhaAluno', 'student'),
    ('Natsuki Ono', 'natsuki.ono@escola.com', 'senhaAluno', 'student'),
    ('Hiroshi Hashimoto', 'hiroshi.hashimoto@escola.com', 'senhaAluno', 'student'),
    ('Akane Sakurai', 'akane.sakurai@escola.com', 'senhaAluno', 'student'),
    ('Koji Inoue', 'koji.inoue@escola.com', 'senhaAluno', 'student'),
    ('Yumi Sasaki', 'yumi.sasaki@escola.com', 'senhaAluno', 'student'),
    ('Shinichi Hirose', 'shinichi.hirose@escola.com', 'senhaAluno', 'student'),
    ('Mika Kurata', 'mika.kurata@escola.com', 'senhaAluno', 'student'),
    ('Junpei Nishimura', 'junpei.nishimura@escola.com', 'senhaAluno', 'student'),
    ('Eri Yamashita', 'eri.yamashita@escola.com', 'senhaAluno', 'student'),
    ('Toshi Fujiwara', 'toshi.fujiwara@escola.com', 'senhaAluno', 'student'),
    ('Koharu Sugawara', 'koharu.sugawara@escola.com', 'senhaAluno', 'student'),
    ('Daichi Kaneko', 'daichi.kaneko@escola.com', 'senhaAluno', 'student'),
    ('Kana Matsuda', 'kana.matsuda@escola.com', 'senhaAluno', 'student')
;

-- Inserindo alunos do 3º Ano B
INSERT INTO users (name, email, password, role) VALUES
    ('Ren Katou', 'ren.katou@escola.com', 'senhaAluno', 'student'),
    ('Shiori Oda', 'shiori.oda@escola.com', 'senhaAluno', 'student'),
    ('Makoto Sakamoto', 'makoto.sakamoto@escola.com', 'senhaAluno', 'student'),
    ('Tomoya Uchida', 'tomoya.uchida@escola.com', 'senhaAluno', 'student'),
    ('Sayaka Yasuda', 'sayaka.yasuda@escola.com', 'senhaAluno', 'student'),
    ('Yuta Ando', 'yuta.ando@escola.com', 'senhaAluno', 'student'),
    ('Saki Kamijo', 'saki.kamijo@escola.com', 'senhaAluno', 'student'),
    ('Takuya Hosoda', 'takuya.hosoda@escola.com', 'senhaAluno', 'student'),
    ('Moe Miyamoto', 'moe.miyamoto@escola.com', 'senhaAluno', 'student'),
    ('Kenta Hasegawa', 'kenta.hasegawa@escola.com', 'senhaAluno', 'student'),
    ('Chihiro Naito', 'chihiro.naito@escola.com', 'senhaAluno', 'student'),
    ('Yosuke Baba', 'yosuke.baba@escola.com', 'senhaAluno', 'student'),
    ('Naoko Arai', 'naoko.arai@escola.com', 'senhaAluno', 'student'),
    ('Tsubasa Kanai', 'tsubasa.kanai@escola.com', 'senhaAluno', 'student'),
    ('Ami Tadokoro', 'ami.tadokoro@escola.com', 'senhaAluno', 'student'),
    ('Rei Nomura', 'rei.nomura@escola.com', 'senhaAluno', 'student'),
    ('Fumiko Uehara', 'fumiko.uehara@escola.com', 'senhaAluno', 'student'),
    ('Shota Ikeda', 'shota.ikeda@escola.com', 'senhaAluno', 'student'),
    ('Hitomi Tamura', 'hitomi.tamura@escola.com', 'senhaAluno', 'student'),
    ('Yuri Koyanagi', 'yuri.koyanagi@escola.com', 'senhaAluno', 'student'),
    ('Kohei Murata', 'kohei.murata@escola.com', 'senhaAluno', 'student'),
    ('Minori Takada', 'minori.takada@escola.com', 'senhaAluno', 'student'),
    ('Kazuki Nishida', 'kazuki.nishida@escola.com', 'senhaAluno', 'student'),
    ('Saori Harada', 'saori.harada@escola.com', 'senhaAluno', 'student'),
    ('Taro Arakawa', 'taro.arakawa@escola.com', 'senhaAluno', 'student'),
    ('Misaki Oki', 'misaki.oki@escola.com', 'senhaAluno', 'student'),
    ('Shingo Komori', 'shingo.komori@escola.com', 'senhaAluno', 'student'),
    ('Ayako Miyagi', 'ayako.miyagi@escola.com', 'senhaAluno', 'student'),
    ('Rina Machida', 'rina.machida@escola.com', 'senhaAluno', 'student'),
    ('Kazue Matsui', 'kazue.matsui@escola.com', 'senhaAluno', 'student')
;


-- Inserindo Anderson como administrador
INSERT INTO users (name, email, password, role) VALUES (
    'Anderson', 'anderson@escola.com', 'senhaSegura', 'admin'
);

-- Inserindo professores
INSERT INTO users (name, email, password, role) VALUES 
    ('Prof. Carlos', 'carlos@escola.com', 'senhaProfessor1', 'teacher'),
    ('Prof. Ana', 'ana@escola.com', 'senhaProfessor2', 'teacher'),
    ('Prof. Amanda', 'amanda@escola.com', 'senhaProfessor3', 'teacher'),
    ('Prof. Renata', 'renata@escola.com', 'senhaProfessor4', 'teacher'),
    ('Prof. Rodrigo', 'rodrigo@escola.com', 'senhaProfessor5', 'teacher'),
    ('Prof. Diego', 'diego@escola.com', 'senhaProfessor6', 'teacher'),
    ('Prof. Felipe', 'felipe@escola.com', 'senhaProfessor7', 'teacher'),
    ('Prof. Mônica', 'monica@escola.com', 'senhaProfessor8', 'teacher'),
    ('Prof. Fernanda', 'fernanda@escola.com', 'senhaProfessor9', 'teacher'),
    ('Prof. Mauro', 'mauro@escola.com', 'senhaProfessor10', 'teacher')
;

-- Matriculando 30 alunos na turma "1º Ano A" (class_id = 1)
INSERT INTO enrollments (user_id, class_id) VALUES 
    (1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
    (6, 1), (7, 1), (8, 1), (9, 1), (10, 1),
    (11, 1), (12, 1), (13, 1), (14, 1), (15, 1),
    (16, 1), (17, 1), (18, 1), (19, 1), (20, 1),
    (21, 1), (22, 1), (23, 1), (24, 1), (25, 1),
    (26, 1), (27, 1), (28, 1), (29, 1), (30, 1)
;

-- Matriculando 30 alunos na turma "1º Ano B" (class_id = 2)
INSERT INTO enrollments (user_id, class_id) VALUES 
    (31, 2), (32, 2), (33, 2), (34, 2), (35, 2),
    (36, 2), (37, 2), (38, 2), (39, 2), (40, 2),
    (41, 2), (42, 2), (43, 2), (44, 2), (45, 2),
    (46, 2), (47, 2), (48, 2), (49, 2), (50, 2),
    (51, 2), (52, 2), (53, 2), (54, 2), (55, 2),
    (56, 2), (57, 2), (58, 2), (59, 2), (60, 2)
;

-- Matriculando 30 alunos na turma "2º Ano A" (class_id = 3)
INSERT INTO enrollments (user_id, class_id) VALUES 
    (61, 3), (62, 3), (63, 3), (64, 3), (65, 3),
    (66, 3), (67, 3), (68, 3), (69, 3), (70, 3),
    (71, 3), (72, 3), (73, 3), (74, 3), (75, 3),
    (76, 3), (77, 3), (78, 3), (79, 3), (80, 3),
    (81, 3), (82, 3), (83, 3), (84, 3), (85, 3),
    (86, 3), (87, 3), (88, 3), (89, 3), (90, 3)
;

-- Matriculando 30 alunos na turma "2º Ano B" (class_id = 4)
INSERT INTO enrollments (user_id, class_id) VALUES 
    (91, 4), (92, 4), (93, 4), (94, 4), (95, 4),
    (96, 4), (97, 4), (98, 4), (99, 4), (100, 4),
    (101, 4), (102, 4), (103, 4), (104, 4), (105, 4),
    (106, 4), (107, 4), (108, 4), (109, 4), (110, 4),
    (111, 4), (112, 4), (113, 4), (114, 4), (115, 4),
    (116, 4), (117, 4), (118, 4), (119, 4), (120, 4)
;

-- Matriculando 30 alunos na turma "3º Ano A" (class_id = 5)
INSERT INTO enrollments (user_id, class_id) VALUES 
    (121, 5), (122, 5), (123, 5), (124, 5), (125, 5),
    (126, 5), (127, 5), (128, 5), (129, 5), (130, 5),
    (131, 5), (132, 5), (133, 5), (134, 5), (135, 5),
    (136, 5), (137, 5), (138, 5), (139, 5), (140, 5),
    (141, 5), (142, 5), (143, 5), (144, 5), (145, 5),
    (146, 5), (147, 5), (148, 5), (149, 5), (150, 5)
;

-- Matriculando 30 alunos na turma "3º Ano B" (class_id = 6)
INSERT INTO enrollments (user_id, class_id) VALUES 
    (151, 6), (152, 6), (153, 6), (154, 6), (155, 6),
    (156, 6), (157, 6), (158, 6), (159, 6), (160, 6),
    (161, 6), (162, 6), (163, 6), (164, 6), (165, 6),
    (166, 6), (167, 6), (168, 6), (169, 6), (170, 6),
    (171, 6), (172, 6), (173, 6), (174, 6), (175, 6),
    (176, 6), (177, 6), (178, 6), (179, 6), (180, 6)
;