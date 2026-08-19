final: prev: {
  lspmux = prev.lspmux.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (builtins.toFile "lspmux-initialize-notifications.patch" ''
        diff --git a/src/instance.rs b/src/instance.rs
        index a0af030..ec2727a 100644
        --- a/src/instance.rs
        +++ b/src/instance.rs
        @@ -518,10 +518,19 @@ async fn initialize_handshake(
        -    let res = match reader
        -        .read_message()
        -        .await
        -        .context("receive initialize response")?
        -        .context("stream ended")?
        -    {
        -        Message::ResponseSuccess(res) if res.id == request_id => res,
        -        _ => bail!("first server message was not initialize response"),
        +    // LSP permits log, progress, and telemetry messages while the server is
        +    // initializing. Ignore them until the matching response arrives.
        +    let res = loop {
        +        match reader
        +            .read_message()
        +            .await
        +            .context("receive initialize response")?
        +            .context("stream ended")?
        +        {
        +            Message::ResponseSuccess(res) if res.id == request_id => break res,
        +            msg => {
        +                warn!(
        +                    ?msg,
        +                    "ignoring message while waiting for initialize response"
        +                );
        +            }
        +        }
             };
             let result = serde_json::from_value(res.result).context("parse initialize response result")?;
      '')
    ];
  });
}
