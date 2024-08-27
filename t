{'input_ids': tensor([[128009, 128009, 128009,  ...,   1229,     18,   3135],
        [128009, 128009, 128009,  ...,    311,   1948,  21425],
        [128009, 128009, 128009,  ...,   3775,    482,   8336],
        ...,
        [128009, 128009, 128009,  ...,     43,     41,   4977],
        [128009, 128009, 128009,  ...,     79,   2096,     65],
        [128009, 128009, 128009,  ...,  30693,    753,   4333]],
       device='cuda:0'), 'attention_mask': tensor([[0, 0, 0,  ..., 1, 1, 1],
        [0, 0, 0,  ..., 1, 1, 1],
        [0, 0, 0,  ..., 1, 1, 1],
        ...,
        [0, 0, 0,  ..., 1, 1, 1],
        [0, 0, 0,  ..., 1, 1, 1],
        [0, 0, 0,  ..., 1, 1, 1]], device='cuda:0'), 'embed_mask': tensor([[0, 0, 0,  ..., 0, 0, 0],
        [0, 0, 0,  ..., 0, 0, 0],
        [0, 0, 0,  ..., 0, 0, 0],
        ...,
        [0, 0, 0,  ..., 0, 0, 0],
        [0, 0, 0,  ..., 0, 0, 0],
        [0, 0, 0,  ..., 0, 0, 0]], device='cuda:0')}


   def compute_loss(
        self,
        model: nn.Module,
        inputs: Dict[str,Union[torch.Tensor, Any]],
        return_outputs: bool = False,
    ) ->Union[Tuple[torch.Tensor, torch.Tensor], torch.Tensor]:
        print("print inputs: ",inputs)
        #labels=inputs.pop("labels")
        input_dict, labels=inputs

        outputs=model(input_dict)#(sentence_feature)#(input_ids)#, embed_mask"=embed_mask)#, attention_mask=attention_mask)#model(**input_dict)
        representation=outputs.last_hidden_state[:, 0, :]
        predictions=self.mlp(representation).squeeze(-1)


  File "/usr/local/lib/python3.10/dist-packages/peft/peft_model.py", line 762, in forward
    return self.get_base_model()(*args, **kwargs)
  File "/usr/local/lib/python3.10/dist-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/usr/local/lib/python3.10/dist-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
TypeError: LlamaModel.forward() got an unexpected keyword argument 'embed_mask'
  0%|                                                     | 0/225 [00:00<?, ?it/s]
        loss=nn.MSELoss()(predictions, labels.float())
        if return_outputs:
            return (loss, outputs)
        return loss
