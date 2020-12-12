namespace superdense_communication {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;

    operation Entangle(qubit1 : Qubit, qubit2 : Qubit) : Unit {
        H(qubit1);
        CNOT(qubit1, qubit2);
    }

    operation Encode(qubit : Qubit, data : Bool []) : Unit {
        if (data[0]) {
            Z(qubit);
        }

        if (data[1]) {
            X(qubit);
        }
    }

    operation Decode(qubit1 : Qubit, qubit2 : Qubit) : Bool [] {
        CNOT(qubit1, qubit2);
        H(qubit1);

        return [ResultAsBool(M(qubit1)), ResultAsBool(M(qubit2))];
    }

    @EntryPoint()
    operation Main() : Unit {
        using ((aliceQubit, bobQubit) = (Qubit(), Qubit())) {
            Entangle(aliceQubit, bobQubit);

            let dataToBeSent = [true, true];
            Encode(aliceQubit, dataToBeSent);

            let dataRecieved = Decode(aliceQubit, bobQubit);

            if (dataRecieved[0] == dataToBeSent[0] and dataRecieved[1] == dataToBeSent[1]) {
                Message("Successful communication");
            } else {
                Message("Error in communication");
            }
            Reset(aliceQubit); Reset(bobQubit);
        }
    }
}

