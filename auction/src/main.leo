// The 'auction' program.
program auction.aleo {
    record Bid{
        owner: address,
        bidder: address,
        amount: u64,
        is_winner: bool
    }
     // Returns a new bid.
    // - `bidder` : The address of the account that placed the bid.
    // - `amount` : The amount of the bid.
    // Requires that `bidder` matches the function caller.
    // The owner of the record is set to the entity responsible for running the auction (auction runner).
    // The address of the auction runner is aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh.
    transition place_bid(bidder: address, amount: u64) -> Bid{
        assert_eq(self.caller, bidder);
        return Bid{
            owner: aleo1medtgn2gy9knpjq2l7hrmjrpkk8umm42j94jwn67hw8eqqeg6vrs6zn9a9,
            bidder: bidder,
            amount: amount,
            is_winner: false
        };
    }
    transition resolve (first: Bid, second: Bid) ->  Bid {
        assert_eq(self.caller, aleo1medtgn2gy9knpjq2l7hrmjrpkk8umm42j94jwn67hw8eqqeg6vrs6zn9a9);
        if (first.amount >= second.amount){
            return first;
        }else{
            return second;
        }
    }
    transition finish(bid: Bid) -> Bid{
        assert_eq(self.caller, aleo1medtgn2gy9knpjq2l7hrmjrpkk8umm42j94jwn67hw8eqqeg6vrs6zn9a9);
        return Bid{
            owner: bid.bidder,
            bidder: bid.bidder,
            amount: bid.amount,
            is_winner: true
        };
    }
}
