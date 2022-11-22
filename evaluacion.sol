// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.9.0;
pragma experimental ABIEncoderV2;

// -----------------------------------
//  ALUMNO   |    ID    |      NOTA
// -----------------------------------
//  Rene     |    77755N    |      5
//  Leo      |    12345X    |      9
//  Libe     |    02468T    |      2
//  Ander    |    13579U    |      3
//  Janire   |    98765Z    |      5

contract Evaluacion {
    
    // Direccion del profesor
    address public profesor;
    
    // Constructor 
    constructor () public {
        profesor = msg.sender;
    }
    
    // Mapping para relacionar el hash de la identidad del alumno con su nota del examen
    mapping (bytes32 => uint) Notas;
    
    // Array de los alumnos de pidan revisiones de examen
    string [] revisiones_solicitadas;
    
    // Eventos 
    event alumno_evaluado(bytes32);
    event solicitud_revision(string);
    
    // Funcion para evaluar a alumnos
    function Evaluar(string memory _idAlumno, uint _nota) public profesorado(msg.sender){
        // Hash de la identificacion del alumno 
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        // Relacion entre el hash de la identificacion del alumno y su nota
        Notas[hash_idAlumno] = _nota;
        // Emision del evento
        emit alumno_evaluado(hash_idAlumno);
    }
    
    // Control de las funciones ejecutables por el profesor
    modifier profesorado(address _direccion){
        // Requiere que la direccion introducido por parametro sea igual al owner del contrato
        require(_direccion == profesor, "Funcion evaluar reservada unicamente al profesorado.");
        _;
    }
    
    // Funcion para ver las notas de un alumno 
    function VerNotas(string memory _idAlumno) public view returns(uint) {
        // Hash de la identificacion del alumno 
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        // Nota asociada al hash del alumno
        uint nota_alumno = Notas[hash_idAlumno];
        // Visualizar la nota 
        return nota_alumno;
    } 
    
    // Funcion para pedir una revision del examen
    function Revision(string memory _idAlumno) public {
        // Almacenamiento de la identidad del alumno en un array dinamico
        revisiones_solicitadas.push(_idAlumno);
        // Emision del evento 
        emit solicitud_revision(_idAlumno);
    }
    
    // Funcion para ver los alumnos que han solicitado revision de examen
    function VerRevisiones() public view profesorado(msg.sender) returns (string [] memory){
        // Devolver las identidades de los alumnos volcando el array dinamico "revisiones_solicitadas"
        return revisiones_solicitadas;
    }
    
}
