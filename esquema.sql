CREATE TABLE pacientes (
    id_paciente  serial,
    cedula       VARCHAR(20)  NOT NULL,
    nombre       VARCHAR(100) NOT NULL,
    apellido     VARCHAR(100) NOT NULL,
    fecha_nac    DATE NOT NULL,
    tipo_sangre  VARCHAR(5)   NOT NULL,

    CONSTRAINT pk_pacientes PRIMARY KEY(id_paciente),
    CONSTRAINT uq_pacientes_cedula UNIQUE(cedula)
);
CREATE TABLE medicos (
    id_medico    serial,
    nombre       VARCHAR(100) NOT NULL,
    apellido     VARCHAR(100) NOT NULL,
    tarjeta_prof VARCHAR(50)  NOT NULL,
    especialidad VARCHAR(100) NOT NULL,

    CONSTRAINT pk_medicos PRIMARY KEY(id_medico),
    CONSTRAINT uq_medicos_tarjeta UNIQUE(tarjeta_prof)
);
CREATE TABLE citas (
    id_cita       serial,
    id_paciente     INT          NOT NULL,
    id_medico       INT,
    fecha_hora      TIMESTAMP    NOT NULL,
    motivo_consulta VARCHAR(500) NOT NULL,

    CONSTRAINT pk_citas  PRIMARY KEY(id_cita),
    CONSTRAINT fk_citas_paciente FOREIGN KEY(id_paciente)
    REFERENCES pacientes(id_paciente) ON DELETE RESTRICT,
    CONSTRAINT fk_citas_medico   FOREIGN KEY(id_medico)
    REFERENCES medicos(id_medico) ON DELETE SET NULL
);

CREATE TABLE historias_clinicas (
    id_historia serial,
    id_cita     INT  NOT NULL,
    diagnostico VARCHAR(1000) NOT NULL,
    tratamiento VARCHAR(1000) NOT NULL,

    CONSTRAINT pk_historias PRIMARY KEY (id_historia),
    CONSTRAINT uq_historias_cita UNIQUE  (id_cita),
    CONSTRAINT fk_historias_cita FOREIGN KEY (id_cita)
    REFERENCES citas(id_cita) ON DELETE RESTRICT
);
CREATE TABLE signos_vitales (
    id_lectura     serial,
    id_paciente     INT          NOT NULL,
    frecuencia_card INT          NOT NULL,
    temperatura     DECIMAL NOT NULL,
    fecha_hora      TIMESTAMP    NOT NULL,

    CONSTRAINT pk_signos  PRIMARY KEY (id_lectura),
    CONSTRAINT fk_signos_paciente FOREIGN KEY (id_paciente)
    REFERENCES pacientes(id_paciente) ON DELETE CASCADE
);
