import { fireEvent, render } from '@solidjs/testing-library'
import { describe, expect, it } from 'vitest'
import { Counter } from './Counter'

describe('Counter', () => {
  it('starts at the given value and increments on click', async () => {
    const { getByRole, getByText } = render(() => <Counter start={3} />)
    expect(getByText(/3 times/)).toBeTruthy()
    await fireEvent.click(getByRole('button'))
    expect(getByText(/4 times/)).toBeTruthy()
  })
})
