pragma solidity 0.4.18;

contract Grandfather {
    bool public grandfatherCalled;

    function pickUpFromKindergarten() internal {
        grandfatherCalled = true;
    }
}

contract Mom is Grandfather {
    bool public momCalled;

    function pickUpFromKindergarten() internal {
        momCalled = true;
    }
}

contract Dad is Grandfather {
    bool public dadCalled;

    function pickUpFromKindergarten() internal { // Ok. Dad have been called.
        dadCalled = true;
        super.pickUpFromKindergarten(); // And who is super here?
                                        // Only one parent. Yep? Grandfather?
                                        // NO! MOM! Be carefull about C3 linearization ¯\_(ツ)_/¯
    }
}

contract Son is Mom, Dad {

    function sonWannaHome() public {
        super.pickUpFromKindergarten(); // who is super here? Mom or Dad? Hint: Dad
    }
}