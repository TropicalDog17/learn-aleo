// The 'zk_suggestion_box' program.
program zk_suggestion_box.aleo {
    record Suggestion{
        // Currently use u64, should use field type instead.
        box_id: u64,
        owner: address,
        receiver: address,
        timestamp: u64,
        is_finalized: bool,
        is_permissioned: bool,
        message: field
    }

    mapping permissionless_box: u64 => u64;
    
    struct SuggestionInfo{
        box_id: u64,
        suggester: address,
        receiver: address,
        timestamp: u64,
        message: field,
    }

    transition initialize_permissionless_box(amount: u64) -> u64{

        let id: u64 = 1u64;

        return id then finalize(id, amount);
    }

    // set the maximum suggestion a box should receive
    finalize initialize_permissionless_box(public id: u64, amount: u64) {
        Mapping::set(permissionless_box, id, amount);
    }

    transition permissionless_publish(info: SuggestionInfo) -> Suggestion {
        let suggestion: Suggestion = Suggestion{
            box_id: info.box_id,
            owner: self.caller,
            receiver: info.receiver,
            timestamp: info.timestamp,
            is_finalized: false,
            is_permissioned: false,
            message: info.message,
        };
        return suggestion then finalize(info.box_id);
    }

    finalize permissionless_publish (box_id: u64){
        let current_value: u64 = Mapping::get_or_use(permissionless_box, box_id, 0u64);
        Mapping::set(permissionless_box, box_id, current_value - 1u64);

    }
}
