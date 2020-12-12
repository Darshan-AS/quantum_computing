namespace entanglement {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation Entangle(qubit1 : Qubit, qubit2 : Qubit) : Unit {
        H(qubit1);
        CNOT(qubit1, qubit2);
    }

    @EntryPoint()
    operation Main() : Unit {
        using ((qubit1, qubit2) = (Qubit(), Qubit())) {
            Message($"Initilaized (qubit1, qubit2) to ({M(qubit1)}, {M(qubit2)})");
            Entangle(qubit1, qubit2);
            Message($"Measured    (qubit1, qubit2) as ({M(qubit1)}, {M(qubit2)})");
        }
    }
}

