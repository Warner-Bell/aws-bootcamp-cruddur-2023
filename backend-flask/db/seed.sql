-- this file was manually created
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('Alt Bell', 'warner.bell21@gmail.com' , 'altbell' ,'MOCK'),
  ('Warner Bell', 'warner.bell@outlook.com' , 'warner' ,'MOCK');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'altbell' LIMIT 1),
    'This was imported as seed data! isnt it delighful?',
    current_timestamp + interval '10 day'
  ),
  (
    (SELECT uuid from public.users WHERE users.handle = 'warner' LIMIT 1),
    'I am not Dembe',
    current_timestamp + interval '10 day'
  );
 