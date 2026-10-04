import { createSignal } from 'solid-js'

export interface CounterProps {
  /** Initial value. Not reactive by design — pass a keyed component if you need that. */
  start?: number
}

/** Minimal interactive island: proof the workspace compiles + tests TSX. */
export function Counter(props: CounterProps) {
  const [count, setCount] = createSignal(props.start ?? 0)
  return (
    <button type="button" onClick={() => setCount((c) => c + 1)}>
      clicked {count()} times
    </button>
  )
}
