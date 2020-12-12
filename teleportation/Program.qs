namespace teleportation {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;

    operation Entangle(qubit1 : Qubit, qubit2 : Qubit) : Unit {
        H(qubit1);
        CNOT(qubit1, qubit2);
    }

    operation Decode(qubit : Qubit, data : Bool []) : Unit {
        if (data[0]) {
            Z(qubit);
        }

        if (data[1]) {
            X(qubit);
        }
    }

    operation Encode(qubit1 : Qubit, qubit2 : Qubit) : Bool [] {
        CNOT(qubit1, qubit2);
        H(qubit1);

        return [ResultAsBool(M(qubit1)), ResultAsBool(M(qubit2))];
    }

    @EntryPoint()
    operation Main() : Unit {
        using ((aliceQubit, bobQubit1, bobQubit2) = (Qubit(), Qubit(), Qubit())) {
            Entangle(bobQubit1, bobQubit2);

            H(aliceQubit); T(aliceQubit);
            let dataMeasured = Encode(aliceQubit, bobQubit1);
            Decode(bobQubit2, dataMeasured);

            Message("Successful teleportation");
            Reset(aliceQubit); Reset(bobQubit1); Reset(bobQubit2);
        }
    }
}

