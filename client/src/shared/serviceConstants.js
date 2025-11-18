export const RATE_TIME_FRAMES = [
    {caption: 'Flat Fee', value: 0},
    {caption: 'per 1/2 Hour', value: 1},
    {caption: 'per Hour', value: 2},
    {caption: 'per Day', value: 3}
]

export const START_TIME_OPTIONS = [
    {caption: 'On the quarter hour (:00, :15, :30, :45)', value: 0},
    {caption: 'On the half hour (:00, :30)', value: 1},
    {caption: 'On the hour (:00)', value: 2}
]

export const TIME_BLOCK_OPTIONS = [
    {caption: 'None', value: 0},
    {caption: ':15', value: 15},
    {caption: ':30', value: 30},
    {caption: ':45', value: 45},
    {caption: '1:00', value: 60},
    {caption: '1:15', value: 75},
    {caption: '1:30', value: 90},
    {caption: '1:45', value: 105},
    {caption: '2:00', value: 120},
    {caption: '2:30', value: 150},
    {caption: '3:00', value: 180},
    {caption: '3:30', value: 210},
    {caption: '4:00', value: 240},
    {caption: '5:00', value: 300},
    {caption: '6:00', value: 360},
    {caption: '7:00', value: 420},
    {caption: '8:00', value: 480},
]

export const LEAD_TYPES_SINGULAR = [
    {caption: 'Minute', value: 0},
    {caption: 'Hour', value: 1},
    {caption: 'Day', value: 2}
]

export const LEAD_TYPES_PLURAL = [
    {caption: 'Minutes', value: 0},
    {caption: 'Hours', value: 1},
    {caption: 'Days', value: 2}
]

export const valueIndex = (jsonArray, searchForValue) => {
    return jsonArray.findIndex(e => e.value === searchForValue)
}

export default valueIndex
