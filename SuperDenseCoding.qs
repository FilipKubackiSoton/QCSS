namespace Qexp {
    open Microsoft.Quantum.Intrinsic; //packages / namespaces 
    open Microsoft.Quantum.Measurement;

    newtype ProtocolMessage  = (Bit1 : Bool, Bit2 : Bool); //user definded type 

    operation CreateEntangledPair (q1 : Qubit, q2 : Qubit) : Unit is Adj //return type Unit - unitary transofrmation, Adj - adjoint transofrmation
    {
        H(q1);
        CNOT(q1, q2);
    }
    
    operation EncodeMessageInQubit (qAlice : Qubit, message : ProtocolMessage) : Unit {
        if (message::Bit1) { Z(qAlice); } //message::Bit1 access Bit1 from ProtocolMessage
        if (message::Bit2) { X(qAlice); }
    }

    operation DecodeMessageFromQubits (qAlice : Qubit, qBob : Qubit) : ProtocolMessage {
        CNOT(qAlice, qBob);
        H(qAlice);
        return ProtocolMessage(MResetZ(qAlice)==One, MResetZ(qBob)==One);
    }

    operation SuperdenseCodingProtocol (message : ProtocolMessage) : ProtocolMessage {
        using(q = Qubit[2]){//allocate two qubits to simulate quantum computing, starting state |00>
            CreateEntangledPair(q[0], q[1]);
            EncodeMessageInQubit(q[0], message);
            return DecodeMessageFromQubits(q[0], q[1]);
        }
    }

    operation SimulateSuperdebseCoding(bit1 : Bool, bit2 : Bool) : ProtocolMessage{
        let message = ProtocolMessage(bit1, bit2);
        return SuperdenseCodingProtocol(message);
    }

}