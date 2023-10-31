program zk_suggestion_box.aleo;

record Suggestion:
    owner as address.private;
    box_id as u64.private;
    receiver as address.private;
    timestamp as u64.private;
    is_finalized as boolean.private;
    is_permissioned as boolean.private;
    message as field.private;

struct SuggestionInfo:
    box_id as u64;
    suggester as address;
    receiver as address;
    timestamp as u64;
    message as field;


mapping permissionless_box:
	key as u64.public;
	value as u64.public;

function initialize_permissionless_box:
    input r0 as u64.private;
    async initialize_permissionless_box 1u64 r0 into r1;    output 1u64 as u64.private;
    output r1 as zk_suggestion_box.aleo/initialize_permissionless_box.future;

finalize initialize_permissionless_box:
    input r0 as u64.public;
    input r1 as u64.public;
    set r1 into permissionless_box[r0];


function permissionless_publish:
    input r0 as SuggestionInfo.private;
    cast self.caller r0.box_id r0.receiver r0.timestamp false false r0.message into r1 as Suggestion.record;
    async permissionless_publish r0.box_id into r2;    output r1 as Suggestion.record;
    output r2 as zk_suggestion_box.aleo/permissionless_publish.future;

finalize permissionless_publish:
    input r0 as u64.public;
    get.or_use permissionless_box[r0] 0u64 into r1;
    sub r1 1u64 into r2;
    set r2 into permissionless_box[r0];
