namespace superposition {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    

    operation MeasureSuperposition() : Result {
        using (q = Qubit()) {
            H(q);
            let result = M(q);
            Reset(q);

            return result;
        }
    }

    operation MeasureSuperpositionNTimes(n : Int) : (Int, Int) {
        mutable oneCount = 0;
        for (i in 0..n) {
            using (q = Qubit()) {
                H(q);
                let result = M(q);
                Reset(q);

                set oneCount += (result == One) ? 1 | 0;
            }
        }
        return (n - oneCount, oneCount);
    }

    @EntryPoint()
    operation Main() : Unit {
        let result = MeasureSuperposition();
        Message("\nMeasured superposition H(q) once");
        Message($"State: {result}");

        let n = 100;
        let (zeroCount, oneCount) = MeasureSuperpositionNTimes(n);
        Message("\nMeasured superposition H(q) for 100 times");
        Message($"Probability of Zero: {zeroCount} / {n}");
        Message($"Probability of One : {oneCount} / {n}");
    }
}

